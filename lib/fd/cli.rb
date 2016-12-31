require "active_support"
require "active_support/core_ext"
require "yaml"
require "fd/analyzer"
require "fd/workspace"

module FD
  module CLI
    autoload :Analyze, "fd/cli/analyze"
    autoload :Command, "fd/cli/command"
    autoload :Console, "fd/cli/console"
    autoload :Engines, "fd/cli/engines"
    autoload :Help, "fd/cli/help"
    autoload :Init, "fd/cli/init"
    autoload :Prepare, "fd/cli/prepare"
    autoload :Runner, "fd/cli/runner"
    autoload :Test, "fd/cli/test"
    autoload :ValidateConfig, "fd/cli/validate_config"
    autoload :Version, "fd/cli/version"

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
