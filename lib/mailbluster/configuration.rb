module Mailbluster
  class Configuration
    attr_accessor :api_key, :api_url, :logger
    def initialize
      @api_url = "https://api.mailbluster.com/api/"
    end
  end
end
