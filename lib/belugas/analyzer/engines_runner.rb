require "securerandom"

module Belugas
  module Analyzer
    class EnginesRunner
      InvalidEngineName = Class.new(StandardError)
      NoEnabledEngines = Class.new(StandardError)

      # def initialize(registry, formatter, source_dir, config, requested_paths = [], container_label = nil)
      def initialize(registry, formatter, source_dir, requested_paths = [], container_label = nil)
        @registry = registry
        @formatter = formatter
        @source_dir = source_dir
        # @config = config
        @requested_paths = requested_paths
        @container_label = container_label
      end

      def run(container_listener = ::CC::Analyzer::ContainerListener.new)
        raise NoEnabledEngines if engines.empty?

        @detected_features = []

        engines.each do |engine|
          next unless engine.can_run? @detected_features
          write_detected_features_file_for engine
          merge_detected_features_from run_engine(engine, container_listener)
        end

        # Buffered output:
        @formatter.started
        @detected_features.each do |detected_feature|
          @formatter.write detected_feature.to_json
        end
        @formatter.finished
      ensure
        @formatter.close if @formatter.respond_to?(:close)
      end

      private

      def write_detected_features_file_for(engine)
        File.write engine.input_detected_features_file.container_path, @detected_features.to_json
      end

      def merge_detected_features_from(new_detected_features)
        feature_names = (@detected_features.map(&:name) + new_detected_features.map(&:name)).uniq

        @detected_features = feature_names.map do |feature_name|
          prv_feature = @detected_features.detect { |f| f.name == feature_name }
          new_feature = new_detected_features.detect { |f| f.name == feature_name }

          if prv_feature && new_feature
            prv_feature.merge new_feature
          else
            new_feature || prv_feature
          end
        end
      end

      attr_reader :requested_paths

      def build_engine(built_config)
        Engine.new(
          built_config.name,
          built_config.registry_entry,
          built_config.code_path,
          built_config.config,
          built_config.container_label,
          built_config.run_rules,
        )
      end

      def configs
        EnginesConfigBuilder.new(
          registry: @registry,
          # config: (@config || {}),
          container_label: @container_label,
          source_dir: @source_dir,
          requested_paths: requested_paths,
        ).run
      end

      def engines
        @engines ||= configs.map { |result| build_engine(result) }
      end

      def run_engine(engine, container_listener)
        engine_detected_features = ArrayWriter.new
        engine.run(engine_detected_features, container_listener)
        engine_detected_features.to_a.map do |feature|
          feature.engines = [engine.name]
          feature
        end
      end
    end
  end
end
