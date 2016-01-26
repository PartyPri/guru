module EnumHelper
  module ClassMethods
    def enum(field, *enum_options)
      @enum_map = to_map(enum_options)
      @field = field
      add_active_record_methods
    end

    private

    def _enum_field
      @field
    end

    def _enum_map
      @enum_map
    end

    def _enum_map_inverted
      @enum_map_inverted ||= @enum_map.invert
    end

    def to_map(array)
      array.each_with_index.inject({}) do |hash, v|
        hash.merge!(v[1] => v[0])
      end
    end

    def add_active_record_methods
      add_field_method(_enum_field, _enum_map)
      _enum_map_inverted.keys.each do |enum_state|
        add_boolean(enum_state)
        add_setter(enum_state)
      end
    end

    def add_field_method(field, map)
      singleton_class.class_eval do
        define_method("#{field}_states") { map }
      end
    end

    def add_boolean(enum_state)
      self.send(:define_method, "#{enum_state}?") do
        field_value = self[self.class._enum_field]
        enum_value = self.class._enum_map_inverted[enum_state]
        field_value == enum_value
      end
    end

    def add_setter(enum_state)
      self.send(:define_method, "#{enum_state}=") do |value|
        raise TypeError.new("must be type TrueClass") unless value == true
        enum_value = self.class._enum_map_inverted[enum_state]
        self[self.class._enum_field] = enum_value
      end
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
  end
end
