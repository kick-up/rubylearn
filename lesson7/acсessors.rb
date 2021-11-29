module Acсessors

  def attr_accessor_with_history(*attributes)
    attributes.each do |attribute|
      var_name = "@#{attribute}".to_sym
      var_name_history = "@#{attribute}_history".to_sym


      define_method(attribute) {instance_variable_get (var_name)}
      define_method("#{attribute}_history") { instance_variable_get(var_name_history) }

      define_method("#{attribute}=".to_sym) do |value|
        if instance_variable_get (var_name_history).nil?
          instance_variable_set (var_name_history)
        else
          value = instance_variable_get(var_name)
          instance_variable_set(var_name_history,value)
        end
          instance_variable_set(var_name,value)
      end
    end
  end

  def strong_attr_accessor (attribute, klass)
    var_name = "@#{attribute}".to_sym
    
    define_method(attribute) {instance_variable_get(var_name)}

    define_method("#{attribute}=").to_sym do |value|
      raise "Type error" unless value.is_a?(klass)
      instance_variables_set(var_name,value)
    end
  end  
end
