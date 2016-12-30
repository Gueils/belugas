module FD
  module Analyzer
    module Formatters
      autoload :Formatter, "fd/analyzer/formatters/formatter"
      # autoload :HTMLFormatter, "fd/analyzer/formatters/html_formatter"
      autoload :JSONFormatter, "fd/analyzer/formatters/json_formatter"
      autoload :PlainTextFormatter, "fd/analyzer/formatters/plain_text_formatter"
      autoload :Spinner, "fd/analyzer/formatters/spinner"

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
