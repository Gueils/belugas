# TODO: Use ActiveModel with validations
module Belugas
  module Analyzer
    module FeatureValidations
      autoload :CategoryValidation, "belugas/analyzer/feature_validations/category_validation"
      autoload :NamePresenceValidation, "belugas/analyzer/feature_validations/name_presence_validation"
      autoload :ContentValidation, "belugas/analyzer/feature_validations/content_validation"
      autoload :DescriptionPresenceValidation, "belugas/analyzer/feature_validations/description_presence_validation"
      # autoload :LocationFormatValidation, "belugas/analyzer/feature_validations/location_format_validation"
      # autoload :OtherLocationsFormatValidation, "belugas/analyzer/feature_validations/other_locations_format_validation"
      # autoload :PathExistenceValidation, "belugas/analyzer/feature_validations/path_existence_validation"
      # autoload :PathIsFileValidation, "belugas/analyzer/feature_validations/path_is_file_validation"
      # autoload :PathPresenceValidation, "belugas/analyzer/feature_validations/path_presence_validation"
      # autoload :RelativePathValidation, "belugas/analyzer/feature_validations/relative_path_validation"
      autoload :TypeValidation, "belugas/analyzer/feature_validations/type_validation"
      # autoload :Validation, "belugas/analyzer/feature_validations/validation"

      def self.validations
        constants.sort.map(&method(:const_get)).select do |klass|
          klass.is_a?(Class) && klass.superclass == CC::Analyzer::IssueValidations::Validation
        end
      end
    end
  end
end
