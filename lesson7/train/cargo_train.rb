# frozen_string_literal: true

require_relative '../instancecounter'
require_relative '../manufacturer'
require_relative './train'


class CargoTrain < Train
  def initialize(number)
    @type = :cargo
    super
  end
end
