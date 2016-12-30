module FD
  module CLI
    class Analyze < Command
      include FD::Analyzer

      def initialize(_args = [])
        super
        @engine_options = []
        @path_options = []

        process_args
      end

      def run
        Dir.chdir(MountedPath.code.container_path) do
          # runner = EnginesRunner.new(registry, formatter, source_dir, config, path_options)
          runner = EnginesRunner.new(registry, formatter, source_dir, path_options)
          runner.run
        end

      rescue EnginesRunner::InvalidEngineName => ex
        fatal(ex.message)
      end

      private

      attr_reader :engine_options, :path_options

      def process_args
        while (arg = @args.shift)
          case arg
          when "-f"
            @formatter = Formatters.resolve(@args.shift).new(filesystem)
          when "-e", "--engine"
            @engine_options << @args.shift
          when "--dev"
            @dev_mode = true
          else
            @path_options << arg
          end
        end
      rescue Formatters::Formatter::InvalidFormatterError => e
        fatal(e.message)
      end

      def registry
        EngineRegistry.new(@dev_mode)
      end

      def formatter
        @formatter ||= Formatters::PlainTextFormatter.new(filesystem)
      end

      def source_dir
        MountedPath.code.host_path
      end
    end
  end
end
