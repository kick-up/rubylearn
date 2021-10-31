 #Класс Station (Станция):
 class Train

  attr_accessor :speed, :wagons, :name, :current_station_index 
  attr_reader :number, :route, :type
  #:passanger, :cargo
  
  def initialize(name,number,type,wagons) 
    @name = name
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    @current_station_index = 0
    @route = []
    puts "Поезд #{name} c номером #{number} и количеством вагонов #{wagons} создан, тип #{type}"
  end

  def add_speed(speed)
    @speed += speed
    puts "Поезд #{name} набирает скорость, текущая скорость поезда : #{speed}"
  end

  def stop_train
    unless @speed.zero?
      @speed = 0
      puts "Поезд остановлен,текушая скорость :#{speed}"
    end
  end

  def attach_wagons 
    if @speed.zero?
      @wagons += 1
      puts "К поезду #{name} прицеплен  1 вагон, всего вагонов : #{wagons}"
    else
      puts "Чтобы прицепить вагон к поезду его нужно сначало остановить"
    end
  end

  def detach_wagons 
    if @wagons.zero?
      puts "У поезда #{name} нет вагонов чтобы оцепить" 
    else
      @wagons -= 1
      puts "C поезда #{name} отцеплен 1 вагон всего вагонов : #{wagons}"
    end
  end

  def accept_route(route) 
    @route = route
    @current_station_index = 0
    current_station.train_in(self)
    puts "Поезду #{name} присовен маршрут"
    puts "Поезд #{name} перемещен на первую станцию"
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


class Route
    
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


class Station

  attr_accessor :trains
  attr_reader :name

  def initialize(name)  
    @name = name
    @trains = []
    puts "Станция #{name} создана"
  end

  def train_in(train)           
    @trains << train
    puts "Поезд #{train.name} прибыл на станцию #{name}"
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
    puts "Количество поездов с типом  #{type} #{@trains}"
  end

  def train_out(train) 
    if @trains.any?
      @trains.delete(train)
      puts "Поезд #{train.name} отбыл со станции #{name}"
    end
  end
end

almaty = Station.new('Almaty')
p almaty
astana = Station.new('Astana')
p astana
karaganda = Station.new('Karaganda')
p karaganda
balhash = Station.new('Balhash')
p balhash

talgo = Train.new('Talgo', 101, :passanger, 40)
p talgo
allegro = Train.new('Allegro', 102, :cargo, 10)
p allegro
express = Train.new('Express', 103, :passanger, 50)
p express
kazpost = Train.new('Kazpost', 100, :cargo, 0)
p kazpost
talgo.add_speed(10)
talgo.attach_wagons
p talgo
allegro.attach_wagons
p allegro
express.detach_wagons
p express
kazpost.detach_wagons
p kazpost


barsakelmes = Route.new(almaty,balhash)
p barsakelmes
barsakelmes.transit_station_add(astana)
p barsakelmes
barsakelmes.transit_station_add(karaganda)
p barsakelmes
barsakelmes.transit_station_delete(astana)
p barsakelmes
barsakelmes.stations

almaty.train_in(talgo)
p almaty
astana.train_in(allegro)
p allegro
almaty.train_in(express)
p express
astana.train_out(allegro)
almaty.train_at_station
p almaty
almaty.train_type(:passanger)
almaty.train_out(talgo)
almaty.train_out(express)
almaty.train_at_station
p almaty


talgo.accept_route(barsakelmes)
p talgo
talgo.go_next
p talgo


