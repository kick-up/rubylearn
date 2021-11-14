require_relative '../manufacturer'
require_relative '../instancecounter'
require_relative '../validation'

class Wagon

  include Manufacturer
  include InstanceCounter
  #include Validation

  attr_reader :type
  
  def initialize(type)
    @type = type
    register_instance
  end

end