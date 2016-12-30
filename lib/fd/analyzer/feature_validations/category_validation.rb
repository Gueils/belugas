module FD
  module Analyzer
    module FeatureValidations
      class CategoryValidation < CC::Analyzer::IssueValidations::CategoryValidation
        CATEGORIES = [
          'Language'.freeze,
          'Platform'.freeze,
          'Database'.freeze,
          'Framework'.freeze,
          'Library'.freeze,
          'Dependency Management'.freeze,
          'Service'.freeze,
        ].freeze
      end
    end
  end
end
