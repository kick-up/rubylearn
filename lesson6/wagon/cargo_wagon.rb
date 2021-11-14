require_relative '../instancecounter'
require_relative '../manufacturer'

class CargoWagon < Wagon
  def initialize
    @type = :cargo
  end
end