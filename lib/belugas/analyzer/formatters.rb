module Belugas
  module Analyzer
    module Formatters
      autoload :Formatter, "belugas/analyzer/formatters/formatter"
      # autoload :HTMLFormatter, "belugas/analyzer/formatters/html_formatter"
      autoload :JSONFormatter, "belugas/analyzer/formatters/json_formatter"
      autoload :PlainTextFormatter, "belugas/analyzer/formatters/plain_text_formatter"
      autoload :Spinner, "belugas/analyzer/formatters/spinner"

      FORMATTERS = {
        # html: HTMLFormatter,
        json: JSONFormatter,
        text: PlainTextFormatter,
      }.freeze

      def self.resolve(name)
        FORMATTERS[name.to_sym] or raise Formatter::InvalidFormatterError, "'#{name}' is not a " \
        "valid formatter. Valid options are: #{FORMATTERS.keys.join(", ")}"
      end
    end
  end
end
