require "rainbow"
require "tty/spinner"
require "active_support/number_helper"

module Belugas
  module Analyzer
    module Formatters
      class PlainTextFormatter < Formatter
        def started
          puts colorize("Starting analysis", :green)
        end

        def finished
          puts

          features.each do |feature|
            puts colorize("== #{feature['categories'].join('/')}: #{feature['name']} ==", :yellow)

            print(feature["description"])
            print(colorize(" [#{feature["engine_name"]}]", "#333333"))
            puts

            puts
          end

          print(colorize("Analysis complete! Found #{pluralize(features.size, "feature")}", :green))
          if warnings.size > 0
            print(colorize(" and #{pluralize(warnings.size, "warning")}", :green))
          end
          puts(colorize(".", :green))
        end

        def engine_running(engine, &block)
          super(engine) do
            with_spinner("Running #{current_engine.name}: ", &block)
          end
        end

        def failed(output)
          spinner.stop("Failed")
          puts colorize("\nAnalysis failed with the following output:", :red)
          puts output
          exit 1
        end

        private

        def spinner(text = nil)
          @spinner ||= Spinner.new(text)
        end

        def with_spinner(text)
          spinner(text).start
          yield
        ensure
          spinner.stop
          @spinner = nil
        end

        def colorize(string, *args)
          rainbow.wrap(string).color(*args)
        end

        def rainbow
          @rainbow ||= Rainbow.new.tap do |rainbow|
            rainbow.enabled = false unless @output.tty?
          end
        end

        def features
          @features ||= []
        end

        def warnings
          @warnings ||= []
        end

        def pluralize(number, noun)
          "#{ActiveSupport::NumberHelper.number_to_delimited(number)} #{noun.pluralize(number)}"
        end
      end
    end
  end
end
