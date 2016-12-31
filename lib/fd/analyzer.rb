require 'cc/analyzer'

module FD
  module Analyzer
    autoload :CompositeContainerListener, "fd/analyzer/composite_container_listener"
    autoload :Config, "fd/analyzer/config"
    autoload :Container, "fd/analyzer/container"
    autoload :Engine, "fd/analyzer/engine"
    autoload :EngineOutput, "fd/analyzer/engine_output"
    autoload :EngineOutputFilter, "fd/analyzer/engine_output_filter"
    autoload :EngineRegistry, "fd/analyzer/engine_registry"
    autoload :EnginesConfigBuilder, "fd/analyzer/engines_config_builder"
    autoload :EnginesRunner, "fd/analyzer/engines_runner"
    autoload :Filesystem, "fd/analyzer/filesystem"
    autoload :Formatters, "fd/analyzer/formatters"
    autoload :Feature, "fd/analyzer/feature"
    autoload :FeatureSorter, "fd/analyzer/feature_sorter"
    autoload :FeatureValidations, "fd/analyzer/feature_validations"
    autoload :FeatureValidator, "fd/analyzer/feature_validator"
    autoload :LocationDescription, "fd/analyzer/location_description"
    autoload :LoggingContainerListener, "fd/analyzer/logging_container_listener"
    autoload :MountedPath, "fd/analyzer/mounted_path"
    autoload :RaisingContainerListener, "fd/analyzer/raising_container_listener"
    autoload :SourceBuffer, "fd/analyzer/source_buffer"
    autoload :SourceExtractor, "fd/analyzer/source_extractor"
    # autoload :SourceFingerprint, "fd/analyzer/source_fingerprint"
    autoload :StatsdContainerListener, "fd/analyzer/statsd_container_listener"

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
