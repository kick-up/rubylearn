require_relative '../instancecounter'
require_relative '../manufacturer'

class PassangerWagon < Wagon
  def initialize
    @type = :passenger
  end
end