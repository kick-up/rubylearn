require_relative '../instancecounter'
require_relative '../manufacturer'

class PassangerWagon < Wagon
  attr_reader :number_of_seats, :place
  attr_writer :place

  def initialize(number_of_seats)
    @type = :passenger
    @number_of_seats = number_of_seats
    @place = 0
  end

  def take_place
    @number_of_seats -= 1
    @place += 1
  end

  def busy_place
    place
  end

  def free_place
    number_of_seats
  end

end