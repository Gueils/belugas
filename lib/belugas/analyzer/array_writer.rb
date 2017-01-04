module Belugas
  module Analyzer
    class ArrayWriter
      attr_reader :features, :warnings

      def initialize(*args)
        @features = []
        @warnings = []
      end

      def write(feature_or_warning)
        @features << feature_or_warning.as_feature if feature_or_warning.feature?
      end

      def to_a
        @features
      end

      delegate :each, :<<,  to: :features
    end
  end
end
