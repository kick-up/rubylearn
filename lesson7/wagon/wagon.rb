require_relative '../manufacturer'
require_relative '../instancecounter'
require_relative '../validation'

class Wagon

  include Manufacturer
  include InstanceCounter
  include Validation

  WRONG_TYPE = "Не верный формат: для пассажирского вагона необходимо указать :passenger"\
  "для грузового вагона необходимо указать :cargo"
  attr_reader :type
  attr_accessor :place, :volume, :type
  
  def initialize(type)
    @type = type
    validate!
    register_instance
  end

  def busy_volume
    place
  end

  def free_volume
    volume
  end

  protected

  def validate!
    raise WRONG_TYPE unless type == :cargo || type == :passenger
  end
end