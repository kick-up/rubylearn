require_relative './instancecounter'
require_relative './validation'

class Station
  
  include InstanceCounter
  include Validation

  NAME_FORMAT = /^[\w]{3,}$/i
  WRONG_NAME = "Неверный формат: Неверный формат. Используйте любые 3 латинские буквы, цифры и символы - и _"

  @@stations = []

  attr_accessor :name
  attr_reader :trains

  def self.all
    @@stations
  end

  def initialize(name)  
    @name = name
    @trains = []
    @@stations << self
    register_instance
    validate!
  end

  def train_in(train)           
    @trains << train
  end
                                                                                    
  def train_at_station
    if @trains.any?
      puts "Список поездов находящиеся на станции #{name}:"
    else
      puts "На станции #{name} нет поездов"
    end
  end

  def train_type(type)
    @trains.count {|train| train.type == type}
  end

  def train_out(train) 
    if @trains.any?
      @trains.delete(train)
    end
  end

  protected
  
  def validate!
    raise WRONG_NAME if @name !~ NAME_FORMAT
  end
end
