# TODO: Use ActiveModel with validations
module FD
  module Analyzer
    class FeatureValidator
      CHECKS = FeatureValidations.validations.freeze

      attr_reader :error

      def initialize(feature)
        @feature = feature
        validate
      end

      def validate
        return @valid unless @valid.nil?

        if feature && invalid_messages.any?
          @error = {
            message: "#{invalid_messages.join("; ")}: `#{feature}`.",
            feature: feature,
          }
          @valid = false
        else
          @valid = true
        end
      end
      alias valid? validate

      private

      attr_reader :feature

      def invalid_messages
        @invalid_messages ||= CHECKS.each_with_object([]) do |check, result|
          validator = check.new(feature)
          result << validator.message unless validator.valid?
        end
      end
    end
  end
end
