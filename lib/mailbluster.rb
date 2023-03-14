module Mailbluster
  autoload :VERSION, "mailbluster/version"
  autoload :Utils, "mailbluster/utils"
  autoload :Client, "mailbluster/client"
  autoload :Configuration, "mailbluster/configuration"
  autoload :ResourceType, "mailbluster/resource_type"
  autoload :Resource, "mailbluster/resource"

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
