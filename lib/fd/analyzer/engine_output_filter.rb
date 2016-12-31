module FD
  module Analyzer
    class EngineOutputFilter
      FEATURE_TYPE = "feature".freeze

      def initialize(config = {})
        @config = config
      end

      def filter?(output)
        false
      end
    end
  end
end
