module FD
  module Analyzer
    class MountedPath
      DEFAULT_FEATURE_DETECTOR_TMP = "/tmp/fdet".freeze

      def self.code
        host_prefix = ENV["FEATURE_DETECTOR_CODE"]
        host_prefix ||= ENV["CODE_PATH"] # deprecated

        if ENV["FEATURE_DETECTOR_DOCKER"]
          new(host_prefix, "/code")
        else
          host_prefix ||= Dir.pwd

          new(host_prefix, host_prefix)
        end
      end

      def self.tmp
        host_prefix = ENV["FEATURE_DETECTOR_TMP"]
        host_prefix ||= DEFAULT_FEATURE_DETECTOR_TMP

        if ENV["FEATURE_DETECTOR_DOCKER"]
          new(host_prefix, "/tmp/fdet")
        else
          new(host_prefix, host_prefix)
        end
      end

      def initialize(host_prefix, container_prefix, path = nil)
        @host_prefix = host_prefix
        @container_prefix = container_prefix
        @path = path
      end

      def host_path
        if path
          File.join(host_prefix, path)
        else
          host_prefix
        end
      end

      def container_path
        if path
          File.join(container_prefix, path)
        else
          container_prefix
        end
      end

      def join(path)
        @path = path

        self
      end

      def file?
        File.file?(container_path)
      end

      def read
        File.read(container_path)
      end

      def write(content)
        FileUtils.mkdir_p(File.dirname(container_path))
        File.write(container_path, content)
      end

      def delete
        File.delete(container_path)
      end

      private

      attr_reader :host_prefix, :container_prefix, :path
    end
  end
end
