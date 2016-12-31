module Belugas
  module Analyzer
    class EngineOutput < CC::Analyzer::EngineOutput
      delegate :to_json, to: :as_feature
      def feature?
        parsed_output &&
          parsed_output["type"].present? &&
          parsed_output["type"].downcase == "feature"
      end

      def as_feature
        Feature.new(raw_output)
      end

      private

      def validator
        FeatureValidator.new(parsed_output)
      end
    end
  end
end
