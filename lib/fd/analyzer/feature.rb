module FD
  module Analyzer
    class Feature
      SPEC_FEATURE_ATTRIBUTES = %w[
        categories
        name
        content
        description
        cue_locations
        engines
        meta
        type
      ]

      def initialize(output)
        @output = output
      end

      def as_json(*)
        # parsed_output.reverse_merge!("fingerprint" => fingerprint,)
        parsed_output
      end

      def fingerprint
        parsed_output.fetch("fingerprint") { default_fingerprint }
      end

      # Allow access to hash keys as methods
      SPEC_FEATURE_ATTRIBUTES.each do |key|
        define_method(key) do
          parsed_output[key]
        end
      end

      def path
        parsed_output.fetch("location", {}).fetch("path", "")
      end

      private

      attr_reader :output

      def default_fingerprint
        SourceFingerprint.new(self).compute
      end

      def parsed_output
        @parsed_output ||= JSON.parse(output)
      end
    end
  end
end
