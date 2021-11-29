# frozen_string_literal: true

require_relative './instancecounter'
require_relative './validation'
require_relative './station'

class Route

  OBJECT_NIL = 'Маршрут должен иметь начальную или конечную станцию'
  BIFURCATION = 'Станция не может быть конечной и начальной одновременно'

  include InstanceCounter
  include Validation

  validate :first_station, :type, Station
  validate :last_station, :type, Station

  attr_reader :first_station, :last_station, :transit_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @transit_station = []
    validate!
    register_instance
  end

  def transit_station_add(transit_station)
    @transit_station << transit_station
  end

  def transit_station_delete(transit_station)
    @transit_station.delete(transit_station)
  end

  def stations
    [@first_station, *@transit_station, @last_station]
  end

  protected

  def validate!
    raise OBJECT_NIL if first_station.nil? || last_station.nil?
    raise BIFURCATION if first_station == last_station
  end
end
