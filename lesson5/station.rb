class Station
  include InstanceCounter
  @@station_number = 0
  @@stations = []

  attr_accessor :trains
  attr_reader :name

  def self.all
    @@stations
  end

  def initialize(name)  
    @name = name
    @trains = []
    @@station_number += 1
    @@stations << self
  end

  def train_in(train)           
    @trains << train
    #puts "Поезд #{train.name} прибыл на станцию #{name}"
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
    #puts "Количество поездов с типом  #{type} #{@trains}"
  end

  def train_out(train) 
    if @trains.any?
      @trains.delete(train)
      #puts "Поезд #{train.name} отбыл со станции #{name}"
    end
  end
end
