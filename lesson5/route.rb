class Route
  include InstanceCounter  
  attr_accessor :stations

  def initialize(first_station,last_station)
    @stations = [first_station,last_station]
    puts "Маршрут #{first_station.name} #{last_station.name} создан"
  end

  def transit_station_add(transit_station)
    stations.insert(-2 , transit_station)
    puts "Транзитная станция #{transit_station.name} добавлена в маршрут"
  end

  def transit_station_delete(transit_station)
    stations.delete(transit_station)
    puts "Транзитная станция #{transit_station.name} удалена с маршрута"
  end
end