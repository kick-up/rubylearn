 #Класс Station (Станция):
 class Train

  attr_accessor :speed, :wagons, :name, :current_station_index #Может возвращять текущую скорость
  attr_reader :number, :route

  TYPE = [:passanger, :cargo]
   
  #Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса 
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

  #Может набирать скорость
  def add_speed(speed)
    @speed += speed
    puts "Поезд #{name} набирает скорость, текущая скорость поезда : #{speed}"
  end

  #Может тормозить (сбрасывать скорость до нуля)
  def stop_train
    unless @speed.zero?
      @speed = 0
      puts "Поезд остановлен,текушая скорость :#{speed}"
    end
  end

  #Vожет прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). 
  #Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
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

  #Может принимать маршрут следования (объект класса Route). 
  #При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
  def accept_route(route) 
    @route = route
    puts "Поезду #{name} присовен маршрут #{route.stations}"
    @current_station_index = 0
    @route.stations[@current_station_index]
    puts "Поезд перемещен на первую станцию "
    #<Train:0x00005652a0002be0 @name="Talgo", @number=101, @type=:passanger, @wagons=40, @speed=10, @current_station_index=0, 
    #@route=#<Route:0x00005652a0001150 @stations=[#<Station:0x00005652a0003540 @name="Almaty", @trains=[]>, 
    #<Station:0x00005652a0003068 @name="Karaganda", @trains=[]>, #<Station:0x00005652a0002e10 @name="Balhash", @trains=[]>]>>
  end

  #Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  def go_route

  end

  #Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def route_list

  end

end


class Route
    
  attr_accessor :stations #Может выводить список всех станций по-порядку от начальной до конечной

  #Имеет начальную и конечную станцию, а также список промежуточных станций.
  #Начальная и конечная станции указываютсся при создании маршрута
  def initialize(first_station,last_station)
    @stations = [first_station,last_station]
    puts "Маршрут #{first_station.name} #{last_station.name} создан"
  end

  #Может добавлять промежуточную станцию в список
  def transit_station_add(transit_station)
    stations.insert(-2 , transit_station)
    puts "Транзитная станция #{transit_station.name} добавлена в маршрут"
  end

  #Может удалять промежуточную станцию из списка
  def transit_station_delete(transit_station)
    stations.delete(transit_station)
    puts "Транзитная станция #{transit_station.name} удалена с маршрута"
  end

end


class Station

  attr_accessor :trains
  attr_reader :name

  #Имеет название, которое указывается при ее создании
  def initialize(name)  
    @name = name
    @trains = []
    puts "Станция #{name} создана"
  end

  #Может принимать поезда (по одному за раз)
  def train_in(train)           
    @trains << train
    puts "Поезд #{train.name} прибыл на станцию #{name}"
  end

  #Может возвращать список всех поездов на станции, находящиеся в текущий момент                                                                                       
  def train_at_station
    if @trains.any?
      puts "Список поездов находящиеся на станции #{name}:"
    else
      puts "На станции #{name} нет поездов"
    end
  end

  #Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  def train_at_station_type
    puts "Количество грузовых поездов на станции #{name}"
  end

  #Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции)
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
almaty.train_out(talgo)
almaty.train_out(express)
almaty.train_at_station
p almaty


talgo.accept_route(barsakelmes)
p talgo


