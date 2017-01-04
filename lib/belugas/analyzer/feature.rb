module Belugas
  module Analyzer
    class Feature
      SPEC_FEATURE_ATTRIBUTES = %w[
        categories
        name
        version
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

      def merge(other)
        raise ArgumentError unless other.is_a? Feature
        raise ArgumentError unless other.name == name

        attributes = parsed_output.dup

        %w(categories cue_locations engines).each do |arrayish_key|
          original_value = attributes.fetch arrayish_key, []
          value_to_merge = other.send(arrayish_key)
          next unless value_to_merge
          attributes[arrayish_key] = (original_value + value_to_merge).uniq
        end

        %w(version).each do |refineable_key|
          value_to_refine = other.send(refineable_key)
          next unless value_to_refine
          attributes[refineable_key] = value_to_refine
        end

        %w(meta).each do |mergeable_key|
          original_value = attributes.fetch mergeable_key, {}
          value_to_merge = other.send(mergeable_key)
          next unless value_to_merge
          attributes[mergeable_key] = original_value.merge value_to_merge
        end

        self.class.new JSON.generate(attributes)
      end

      # Allow access to hash keys as methods
      SPEC_FEATURE_ATTRIBUTES.each do |key|
        define_method(key) do
          parsed_output[key]
        end

        define_method("#{key}=".to_sym) do |value|
          parsed_output[key] = value
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
        @parsed_output ||= JSON.parse(output).with_indifferent_access
      end
    end
  end
end
