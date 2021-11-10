class Wagon
  include Manufacturer
  include InstanceCounter
  attr_reader :type
  
  def initialize(type)
    @type = type
  end
end