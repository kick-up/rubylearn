require_relative '../manufacturer'
require_relative '../instancecounter'
require_relative '../validation'

class Wagon

  include Manufacturer
  include InstanceCounter
  include Validation

  WRONG_TYPE = "Не верный формат: для пассажирского вагона необходимо указать :passenger"\
  "для грузового вагона необходимо указать :cargo"
  TYPE = /^\w{1}[a-z]{4,8}$/

  attr_reader :type
  
  def initialize(type)
    @type = type
    validate!
    register_instance
  end

  protected

  def validate!
    raise WRONG_TYPE if type !~TYPE
  end

end