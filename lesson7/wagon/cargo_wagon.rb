require_relative '../instancecounter'
require_relative '../manufacturer'

class CargoWagon < Wagon
  attr_reader :volume, :size
  attr_writer :size

  def initialize(volume)
    @type = :cargo
    @volume = volume
    @size = 0
  end

  def take_volume(size)
     if size < volume
      @volume -= size 
      @size += size
    end
  end

  def busy_volume
    size
  end

  def free_volume
    volume
  end
end