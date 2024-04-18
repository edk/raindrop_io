module RaindropIo
  class Base
    class << self
      def get(path, options = {})
        RaindropIo::Api.get(path, options)
      end
    end

    def initialize(attributes = {})
      initialize_attributes(attributes)
      @attributes = attributes
    end

    def initialize_attributes(attributes)
      attributes.each do |key, value|
        variable_name = (key == "_id") ? :id : key.to_sym
        instance_variable_set(:"@#{variable_name}", value)
        unless self.class.method_defined?(variable_name)
          self.class.send(:attr_reader, variable_name)
        end
      end
    end
  end
end
