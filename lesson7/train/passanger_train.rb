# frozen_string_literal: true

require_relative '../instancecounter'
require_relative '../manufacturer'
require_relative './train'

class PassangerTrain < Train
  def initialize(number)
    @type = :passenger
    super
  end
end
