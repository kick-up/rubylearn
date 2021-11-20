require_relative '../instancecounter'
require_relative '../manufacturer'

class PassangerWagon < Wagon
  attr_reader :volume, :place, :type
  attr_writer :place

  def initialize(volume)
    @type = :passenger
    @volume = volume
    @place = 0
  end

  def take_place
    @volume -= 1
    @place += 1
  end
end