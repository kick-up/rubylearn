module Validation
  def self.included(base)
    base.extend         ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, *params)
      @validations ||= []
      @validations << { name: name, type: type, params: params }
    end
  end

  module InstanceMethods
    def validate_presence(value)
      raise "Value is nil" if value.nil? || value.strip.empty?
    end

    def validate_format(value, format)
      raise "Wrong format" if value !~ format
    end

    def validate_type(value, type)
      raise "Invalid type" unless value.is_a?(type)
    end


    #инстанс-метод validate!, который запускает все проверки (валидации), 
    #указанные в классе через метод класса validate. В случае ошибки валидации 
    #выбрасывает исключение с сообщением о том, какая именно валидация не прошла
    def validate!
      self.class.validations.each do |validation|
        val = instance_variable_get("@#{validation[:name]}")
        send "validate_#{validation[:type]}", val, *validation[:params]
      end
    end

    def valid?
      validate!
      true
    rescue StandardError => e
      false
    end
  end  
end
