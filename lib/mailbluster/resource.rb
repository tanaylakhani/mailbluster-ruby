module Mailbluster
  class Resource
    attr_reader :raw_attributes

    def initialize(resource_type, attributes)
      @resource_type = resource_type
      @raw_attributes = attributes
      map_attributes_to_methods
    end

    private

    attr_reader :resource_type

    def map_attributes_to_methods
      raw_attributes.each_key do |key|
        method_name = Utils.underscore(key.to_s)
        define_singleton_method(method_name) do
          raw_attributes[key]
        end
      end
    end
  end
end
