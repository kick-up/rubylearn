# frozen_string_literal: true

require_relative '../instancecounter'
require_relative '../manufacturer'

class PassangerWagon < Wagon
  attr_accessor :place
  attr_reader :volume, :type

  def initialize(volume)
    @type = :passenger
    @volume = volume
    @place = 0
    super
  end

  def take_place
    @volume -= 1
    @place += 1
  end
end
