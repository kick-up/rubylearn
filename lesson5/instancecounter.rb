module InstanceCounter 
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end


  module ClassMethods
    def instances
      @@instances 
    end

  module InstanceMethods
    def register_instance
      @@instances += 1
    end
  end
end

