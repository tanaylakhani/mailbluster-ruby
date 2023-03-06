module Mailbluster
  class ResourceType
    attr_reader :resource_type

    def initialize(client, resource_type)
      @client = client
      @resource_type = resource_type
    end

    def inspect
      "#<Mailbluster::ResourceType::#{singular_resource_type.capitalize}>"
    end

    def create(new_attributes)
      raw_resource_attributes = @client.post(resource_type, new_attributes)
      Resource.new(self, raw_resource_attributes[singular_resource_type] || raw_resource_attributes)
    end

    def read(id_or_email_md5 = "")
      if lead?
        id_or_email_md5 = Utils.md5(id_or_email_md5) if id_or_email_md5.include?("@")
      end
      if id_or_email_md5.is_a?(Hash)
        query_params = id_or_email_md5.map do |k, v|
          [Utils.camelize(k.to_s), v]
        end.to_h
        id_or_email_md5 = ""
      end
      raw_resource_attributes = @client.get(
        "#{resource_type}/#{id_or_email_md5}",
        query_params: query_params
      )
      if id_or_email_md5 == "" && raw_resource_attributes[resource_type].is_a?(Array)
        raw_resource_attributes[resource_type].map do |rra|
          Resource.new(self, rra)
        end
      else
        Resource.new(self, raw_resource_attributes)
      end
    end

    def update(id_or_email_md5, new_attributes)
      if lead?
        id_or_email_md5 = Utils.md5(id_or_email_md5) if id_or_email_md5.include?("@")
      end
      raw_resource_attributes = @client.put("#{resource_type}/#{id_or_email_md5}", new_attributes)
      Resource.new(self, raw_resource_attributes[singular_resource_type] || raw_resource_attributes)
    end

    def delete(id_or_email_md5)
      if lead?
        id_or_email_md5 = Utils.md5(id_or_email_md5) if id_or_email_md5.include?("@")
      end
      @client.delete("#{resource_type}/#{id_or_email_md5}")
      id_or_email_md5
    end

    def lead?
      resource_type == "leads"
    end

    private

    def singular_resource_type
      resource_type[0..-2]
    end
  end
end
