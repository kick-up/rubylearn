class Glider

  attr_accessor :station

  def initialize
    @station = []
  end

  def lift(station)
    @station << station
    puts "Rising"
  end
  
  def bank
    puts "Turning"  
  end
end

class Nomad

  def initialize(glider)
    @glider = glider
  end

  def do(action, argument = nil)
    if argument == nil
      @glider.send(action)
    else
      @glider.send(action, argument)
    end
  end
end

#nomad = Nomad.new(Glider.new)
#nomad.do("lift")
#nomad.do("bank")


class Initiate
  def initialize(secretive_monk)
    @secretive_monk = secretive_monk
  end
  
  def meaning_of_life
    # change this line to sneakily call `meaning_of_life`, even though
    # it is a private method.
    @secretive_monk.send(:meaning_of_life)
  end
end


def relay(array, data_type)
  array.map {|s| s.send("to_#{data_type}") }
end
