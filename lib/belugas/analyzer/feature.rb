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

        %w(categories cue_locations engines).each do |arrayish_key|
          self.send "#{arrayish_key}=", (self.send(arrayish_key) + other.send(arrayish_key)).uniq
        end

        %w(version).each do |refineable_key|
          self.send "#{refineable_key}=", other.send(refineable_key)
        end

        %w(meta).each do |mergeable_key|
          value_to_merge = other.send(mergeable_key)
          if self.send(mergeable_key).nil?
            self.send "#{mergeable_key}=", value_to_merge
          elsif value_to_merge.present?
            self.send(mergeable_key).merge! value_to_merge
          end
        end
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
        @parsed_output ||= JSON.parse(output)
      end
    end
  end
end
