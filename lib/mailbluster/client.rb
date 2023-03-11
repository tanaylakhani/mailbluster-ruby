require "json"
require "rest-client"

module Mailbluster
  class Client
    Error = Class.new(StandardError)
    Forbidden = Class.new(Error)
    NotFound = Class.new(Error)
    UnprocessableEntity = Class.new(Error)

    RESOURCES = ["leads", "fields", "products", "orders"].freeze

    def initialize(api_key = nil, logger = nil)
      @api_key = api_key ||
                 Mailbluster.configuration.api_key ||
                 ENV["MAILBLUSTER_API_KEY"]
      @api_url = Mailbluster.configuration.api_url ||
                 ENV["MAILBLUSTER_API_URL"]

      @logger = logger || Mailbluster.configuration.logger
    end

    def resource(resource_type)
      raise ArgumentError, "Invalid resource type" unless RESOURCES.include?(resource_type)

      ResourceType.new(self, resource_type)
    end

    RESOURCES.each do |resource_type|
      define_method(resource_type) do
        resource(resource_type)
      end
    end

    def get(subpath, query_params: nil)
      request(:get, subpath, query_params)
    end

    def post(subpath, payload)
      request(:post, subpath, payload)
    end

    def put(subpath, payload = {})
      request(:put, subpath, payload)
    end

    def delete(subpath)
      request(:delete, subpath)
    end

    private

    attr_reader :api_key, :api_url, :logger

    def request(method, subpath, payload = {})
      url = URI.parse(api_url + subpath)
      if method == :get && payload != {}
        url = "#{url}?#{URI.encode_www_form(payload.to_a)}"
        payload = {}
      end

      log("Request: #{method} #{url} #{payload}")
      response = ::RestClient::Request.execute(
        prepare_request_options(method, payload, url)
      )

      log("Response: #{response.code} #{response.body}")

      JSON.parse(response.body)
    rescue RestClient::Forbidden => e
      raise Forbidden, "#{e.message}\nMake sure that you set correct Mailbluster API KEY"
    rescue RestClient::UnprocessableEntity => e
      raise UnprocessableEntity, e.response.body || [
        e.message, "Make sure that you set correct resource attributes"
      ].join("\n")
    rescue RestClient::NotFound => e
      raise NotFound, e.message
    end

    def prepare_request_options(method, payload, url)
      {
        method: method,
        url: url.to_s,
        payload: payload&.to_json,
        headers: {
          content_type: :json,
          accept: :json,
          user_agent: mailbluster_user_agent,
          authorization: api_key
        }
      }
    end

    def mailbluster_user_agent
      [
        "mailbluster-ruby",
        Mailbluster::VERSION,
        RestClient::Platform.default_user_agent
      ].join("/")
    end

    def log(message, level = :info)
      logger&.send(level, "[Mailbluster::Client] #{message}")
    end
  end
end
