class Train
  include Manufacturer
  include InstanceCounter
  attr_writer :wagons
  attr_reader :number, :route, :type, :speed , :wagons

  @@trains = []

  def self.find(number)
      @@trains[number]
  end
  
  def initialize(number) 
    @number = number
    @wagons = []
    @speed = 0
    @current_station_index = 0
    @route = []
    @@trains << self
    puts "#{type} поезд c номером #{number} создан"
  end

  def add_speed(speed)
    @speed += speed
    puts "Поезд #{number} набирает скорость, текущая скорость поезда : #{speed}"
  end

  def stop_train
    unless @speed.zero?
      @speed = 0
      puts "Поезд остановлен,текушая скорость :#{speed}"
    end
  end

  def attach_wagons(wagon)
    return unless @speed.zero?
    return unless attachable_wagon?(wagon)
    @wagons << wagon
    puts "К поезду #{number} прицеплен  1 вагон, всего вагонов : #{wagons}"
  end

  def detach_wagons(wagon)
    if @wagons.any?
      @wagons.delete_at(-1)
      puts "C поезда #{number} отцеплен 1 вагон всего вагонов : #{wagons}"
    else
      puts "У поезда #{number} нет вагонов чтобы оцепить" 
    end
  end

  def attachable_wagon?(wagon)
    self.type == wagon.type
  end

  def accept_route(route) 
    @route = route
    @current_station_index = 0
    current_station.train_in(self)
    #puts "Поезду #{number} присовен маршрут"
    #puts "Поезд #{number} перемещен на первую станцию"
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def show_next_station
    @route.stations[@current_station_index + 1]
  end

  def show_previous_station
    return unless @current_station_index.postitve?
    @route.stations[@current_station_index - 1]
  end

  def go_next
    return if show_next_station.nil?
    current_station.train_out(self)
    @current_station_index += 1
    current_station.train_in(self)
  end

  def go_back
    return if previous_station.nil?
    current_station.train_out(self)
    @current_station_index -= 1
    current_station.train_in(self)
  end
  
end
