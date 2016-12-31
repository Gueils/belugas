require 'cc/analyzer'

module Belugas
  module Analyzer
    autoload :CompositeContainerListener, "belugas/analyzer/composite_container_listener"
    autoload :Config, "belugas/analyzer/config"
    autoload :Container, "belugas/analyzer/container"
    autoload :Engine, "belugas/analyzer/engine"
    autoload :EngineOutput, "belugas/analyzer/engine_output"
    autoload :EngineOutputFilter, "belugas/analyzer/engine_output_filter"
    autoload :EngineRegistry, "belugas/analyzer/engine_registry"
    autoload :EnginesConfigBuilder, "belugas/analyzer/engines_config_builder"
    autoload :EnginesRunner, "belugas/analyzer/engines_runner"
    autoload :Filesystem, "belugas/analyzer/filesystem"
    autoload :Formatters, "belugas/analyzer/formatters"
    autoload :Feature, "belugas/analyzer/feature"
    autoload :FeatureSorter, "belugas/analyzer/feature_sorter"
    autoload :FeatureValidations, "belugas/analyzer/feature_validations"
    autoload :FeatureValidator, "belugas/analyzer/feature_validator"
    autoload :LocationDescription, "belugas/analyzer/location_description"
    autoload :LoggingContainerListener, "belugas/analyzer/logging_container_listener"
    autoload :MountedPath, "belugas/analyzer/mounted_path"
    autoload :RaisingContainerListener, "belugas/analyzer/raising_container_listener"
    autoload :SourceBuffer, "belugas/analyzer/source_buffer"
    autoload :SourceExtractor, "belugas/analyzer/source_extractor"
    # autoload :SourceFingerprint, "belugas/analyzer/source_fingerprint"
    autoload :StatsdContainerListener, "belugas/analyzer/statsd_container_listener"

    class DummyStatsd
      def method_missing(*)
        yield if block_given?
      end
    end

    class DummyLogger
      def method_missing(*)
        yield if block_given?
      end
    end

    cattr_accessor :statsd, :logger
    self.statsd = DummyStatsd.new
    self.logger = DummyLogger.new

    UnreadableFileError = Class.new(StandardError)
  end
end
