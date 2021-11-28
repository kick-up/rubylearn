# frozen_string_literal: true

require_relative '../instancecounter'
require_relative '../validation'
require_relative '../manufacturer'

class Train

  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i.freeze
  WRONG_NAME = 'Неверный формат. Вам необходимо: три буквы латинские буквы '\
  'или цифры в любом порядке необязательный дефис (может быть, а может нет) '\
   'и еще 2 буквы латинские буквы или цифры после дефиса.'

  include Manufacturer
  include InstanceCounter
  include Validation

  attr_accessor :wagons
  attr_reader :number, :route, :type, :speed

  validate :number, :format, NUMBER_FORMAT
  
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
    @speed = 0 unless @speed.zero?
  end

  def attach_wagons(wagon)
    return unless @speed.zero?
    return unless attachable_wagon?(wagon)

    @wagons << wagon
  end

  def detach_wagons(_wagon)
    @wagons.delete_at(-1) if @wagons.any?
  end

  def attachable_wagon?(wagon)
    type == wagon.type
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
    return if show_previous_station.nil?

    current_station.train_out(self)
    @current_station_index -= 1
    current_station.train_in(self)
  end

  def wagon_search(&block)
    wagons.each(&block)
  end

  protected

  def validate!
    raise WRONG_NAME if number !~ NUMBER_FORMAT
  end
end
