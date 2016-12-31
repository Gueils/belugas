require "active_support"
require "active_support/core_ext"
require "yaml"
require "belugas/analyzer"
require "belugas/workspace"

module Belugas
  module CLI
    autoload :Analyze, "belugas/cli/analyze"
    autoload :Command, "belugas/cli/command"
    autoload :Console, "belugas/cli/console"
    autoload :Engines, "belugas/cli/engines"
    autoload :Help, "belugas/cli/help"
    autoload :Init, "belugas/cli/init"
    autoload :Prepare, "belugas/cli/prepare"
    autoload :Runner, "belugas/cli/runner"
    autoload :Test, "belugas/cli/test"
    autoload :ValidateConfig, "belugas/cli/validate_config"
    autoload :Version, "belugas/cli/version"

    def self.debug?
      ENV["FEATURE_DETECTOR_DEBUG"]
    end

    def self.debug(message, values = {})
      if debug?
        if values.any?
          message << " "
          message << values.map { |k, v| "#{k}=#{v.inspect}" }.join(" ")
        end

        $stderr.puts("[DEBUG] #{message}")
      end
    end
  end
end
