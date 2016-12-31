module Belugas
  module Analyzer
    class MountedPath < CC::Analyzer::MountedPath
      DEFAULT_FEATURE_DETECTOR_TMP = "/tmp/fdet".freeze

      def self.code
        host_prefix = ENV["BELUGAS_CODE"]
        host_prefix ||= ENV["CODE_PATH"] # deprecated

        if ENV["BELUGAS_DOCKER"]
          new(host_prefix, "/code")
        else
          host_prefix ||= Dir.pwd
          new(host_prefix, host_prefix)
        end
      end

      def self.tmp
        host_prefix = ENV["FEATURE_DETECTOR_TMP"]
        host_prefix ||= DEFAULT_FEATURE_DETECTOR_TMP

        if ENV["BELUGAS_DOCKER"]
          new(host_prefix, "/tmp/fdet")
        else
          new(host_prefix, host_prefix)
        end
      end
    end
  end
end
