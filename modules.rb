module NameCompany
  attr_accessor :name_company
end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances

    def instances
      @instances ||= 0
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instances ||= 0
      self.class.instances = + 1
    end
  end
end

module Acсessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      @history = {}
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { @history[name] }
        define_method("#{name}=".to_sym) { |value| history[name] << value; instance_variable_set(var_name, value) }
        define_method("#{name}_history") { @history[name] }
      end
    end

    def strong_attr_accessor(name, type)
      define_method(name) { instance_variable_get(name) }

      define_method("#{name}.to_sym") do |value|
        raise 'Неправильный тип присваемого значения' if type != value.type

        instance_variable_set(name, value)
      end
    end
  end
end

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validete(name, type, _args = nil)
      @validations ||= []
      @validations << {names: name, types: type, args: _args}
     	@validations.each {|names, validation| validation!(validation[0], validation[1], validation[2]) }
      end
    end
  end

  module InstanceMethod
    def validate!(name, type, arg = nil)
    	self.class.validate
      var = instance_variable_get("@#{name}")
      send "validate_#{type}", var, arg

    end

    def valid?
      true
    rescue StandardError
      false
    end

    def validate_presence(var, _arg)
      raise 'Переменная = nil' if var.nil? || var.empty?
    end

    def validate_format(var, format)
      raise 'Неверный формат' if var !~ format
    end

    def validate_type(var, type)
      raise 'Неверный тип' if var.is_a? type
    end
  end
end