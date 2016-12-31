module Belugas
  module Analyzer
    module FeatureValidations
      class NamePresenceValidation < CC::Analyzer::IssueValidations::Validation
        def valid?
          object["name"].present?
        end

        def message
          "Name must be present"
        end
      end
    end
  end
end
