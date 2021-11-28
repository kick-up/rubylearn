# frozen_string_literal: true

require_relative '../instancecounter'
require_relative '../manufacturer'
require_relative './wagon'

class CargoWagon < Wagon
  attr_accessor :place
  attr_reader :volume, :type

  def initialize(volume)
    @type = :cargo
    @volume = volume
    @place = 0
    super
  end

  def take_volume(place)
    return unless place < volume

    @volume -= place
    @place += place
  end
end
