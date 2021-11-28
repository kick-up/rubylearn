# frozen_string_literal: true

require_relative './instancecounter'
require_relative './validation'
require_relative './acсessors'

class Station
  
  NAME_FORMAT = /^\w{3,}$/i.freeze
  WRONG_NAME = 'Неверный формат: Неверный формат. Используйте любые 3 латинские буквы, цифры и символы - и _'

  include InstanceCounter
  include Validation
  extend  Acсessors

  attr_accessor_with_history :name
  attr_reader :trains

  validate :name, :presence
  validate :name, :format, NAME_FORMAT

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
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
    @trains.count { |train| train.type == type }
  end

  def train_out(train)
    @trains.delete(train) if @trains.any?
  end

  def train_search(&block)
    trains.each(&block)
  end

  protected

  def validate!
    raise WRONG_NAME if @name !~ NAME_FORMAT
  end
end
