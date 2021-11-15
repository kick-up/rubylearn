require_relative '../instancecounter'
require_relative '../validation'
require_relative '../manufacturer'


class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  attr_writer :wagons
  attr_reader :number, :route, :type, :speed , :wagons

  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i
  WRONG_NAME = "Неверный формат. Вам необходимо: три буквы латинские буквы "\
    "или цифры в любом порядке необязательный дефис (может быть, а может нет) "\
    "и еще 2 буквы латинские буквы или цифры после дефиса."

  @@trains = {}

  def self.find(number)
      @@trains[number]
  end
  
  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    @current_station_index = 0
    @route = []
    validate!
    @@trains[number] = self
    register_instance
  end

  def add_speed(speed)
    @speed += speed
  end

  def stop_train
    unless @speed.zero?
      @speed = 0
    end
  end

  def attach_wagons(wagon)
    return unless @speed.zero?
    return unless attachable_wagon?(wagon)
    @wagons << wagon
  end

  def detach_wagons(wagon)
    if @wagons.any?
      @wagons.delete_at(-1)
    end
  end

  def attachable_wagon?(wagon)
    self.type == wagon.type
  end

  def accept_route(route) 
    @route = route
    @current_station_index = 0
    current_station.train_in(self)
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
    
  protected 

  def validate!
    raise WRONG_NAME if number !~ NUMBER_FORMAT
  end


end
