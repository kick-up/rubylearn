require_relative '../instancecounter'
require_relative '../manufacturer'

class CargoWagon < Wagon
  attr_reader :volume, :place, :type
  attr_writer :place

  def initialize(volume)
    @type = :cargo
    @volume = volume
    @place = 0
  end

  def take_volume(place)
    if place < volume
      @volume -= place
      @place += place
    end
  end
end