# TODO: Use ActiveModel with validations
module FD
  module Analyzer
    module FeatureValidations
      autoload :CategoryValidation, "fd/analyzer/feature_validations/category_validation"
      autoload :NamePresenceValidation, "fd/analyzer/feature_validations/name_presence_validation"
      autoload :ContentValidation, "fd/analyzer/feature_validations/content_validation"
      autoload :DescriptionPresenceValidation, "fd/analyzer/feature_validations/description_presence_validation"
      # autoload :LocationFormatValidation, "fd/analyzer/feature_validations/location_format_validation"
      # autoload :OtherLocationsFormatValidation, "fd/analyzer/feature_validations/other_locations_format_validation"
      # autoload :PathExistenceValidation, "fd/analyzer/feature_validations/path_existence_validation"
      # autoload :PathIsFileValidation, "fd/analyzer/feature_validations/path_is_file_validation"
      # autoload :PathPresenceValidation, "fd/analyzer/feature_validations/path_presence_validation"
      # autoload :RelativePathValidation, "fd/analyzer/feature_validations/relative_path_validation"
      autoload :TypeValidation, "fd/analyzer/feature_validations/type_validation"
      # autoload :Validation, "fd/analyzer/feature_validations/validation"

      def self.validations
        constants.sort.map(&method(:const_get)).select do |klass|
          klass.is_a?(Class) && klass.superclass == CC::Analyzer::IssueValidations::Validation
        end
      end
    end
  end
end
