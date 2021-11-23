# frozen_string_literal: true

require_relative '../instancecounter'
require_relative '../manufacturer'

class CargoTrain < Train
  def initialize(number)
    @type = :cargo
    super
  end
end
