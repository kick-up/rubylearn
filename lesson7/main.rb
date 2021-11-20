require_relative ("route")
require_relative ("station")
require "./wagon/wagon"
require "./wagon/cargo_wagon"
require "./wagon/passanger_wagon"
require "./train/train"
require "./train/cargo_train"
require "./train/passanger_train"



class Main

  def initialize 
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

   TRAIN_TYPES = [PassangerTrain, CargoTrain]
   WAGON_TYPES = [PassangerWagon, CargoWagon]

  def menu
    puts "*********************************************"
    show_list
    puts "*********************************************"
    puts "ПАНЕЛЬ УПРАВЛЕНИЯ ЖЕЛЕЗНОДОРОЖНОЙ СТАНЦИЕЙ"
    puts "*********************************************"
    puts "Выберите соответствующий номер для выполнения"
    puts "1. Создать станцию"
    puts "2. Создать поезд"
    puts "3. Добавить вагон к поезду"
    puts "4. Отцепить вагон от поезда"
    puts "5. Занять место или обьем в вагоне"
    puts "6. Создать маршрут"
    puts "7. Назначить маршрут поезду"
    puts "8. Добавить транзитную станцию в маршрут"
    puts "9. Управление поездом"
    puts "0. Чтобы выйти с программы"
    puts "**************************************************"
    show
  end

  def choice
    loop do 
      menu
      choice = gets.to_i
      case choice
      when 1 then create_station
      when 2 then create_train
      when 3 then attach_wagon_controller
      when 4 then detach_wagon_controller
      when 5 then take_place_or_volume 
      when 6 then create_route
      when 7 then assign_route
      when 8 then add_transit_station
      when 9 then train_controller
      when 0 then exit
      end
    end
  end

  def create_station  
    puts "Введите название станции:"
    begin
      new_station = gets.chomp.capitalize!
      @stations << Station.new(new_station)
      puts "Вы добавили станцию #{new_station}"
    rescue => e
      puts e.inspect
    end
  end

  def create_train
    puts "Выберите тип создаваемого поезда: 1 - Пассажирский, 2 - Грузовой"
    train_type = select_from_collection(TRAIN_TYPES)
    puts "Укажите номер поезда"
    begin
      train_number = gets.chomp
      @trains << train_type.new(train_number)
      puts "Вы добавили поезд под №#{train_number}"
    rescue => e
      puts e.inspect
    end
  end

  def attach_wagon_controller
    puts "Чтобы прицепить вагон к поезду выберите индекс поезда"
    show_collection(@trains)
    train = select_from_collection(@trains)
    puts "Выберите типа вагона: 1- Пассажирский или 2 - Грузовой"
    wagons = gets.to_i
    case wagons
    when 1
      puts "Уажите количество мест пассажирского вагона:"
      volume = gets.to_i
      wagon = PassangerWagon.new(volume)
      train.attach_wagons(wagon)
      @wagons << wagon
    when 2
      puts "Уажите обьем грузового вагона:"
      volume = gets.to_i
      wagon = CargoWagon.new(volume)
      train.attach_wagons(wagon)
      @wagons << wagon
    end
  end

  def detach_wagon_controller
    puts "Чтобы оцепить вагон от поезда выберите поезд по индексу" 
    show_collection(@trains)
    train = select_from_collection(@trains)
    puts "Выберите вагон который хотите оцепить"
    show_collection(train.wagons)
    wagon = gets.to_i
    train.detach_wagons(train.wagons[wagon])
    p train
  end

  def take_place_or_volume
    puts "Выберите поезд"
    show_collection(@trains)
    train = select_from_collection(@trains)
    puts "Выберите вагон"
    show_collection(train.wagons)
    wagon = select_from_collection(train.wagons)
    case train.type
    when :passenger
      puts "Вы заняли одно место"
      wagon.take_place
      free = wagon.free_volume
      puts "Свободные места #{free}"
    when :cargo
      puts "Укажите объем погрузки:"
      volume = gets.to_i
      wagon.take_volume(volume)
      free = wagon.free_volume
      puts "Свободный обьем #{free}"
    end
  end

  def create_route
    puts "Для создания маршрута укажите начальную и конечную станции"
    puts "--------------------------------------------------"
    puts "Укажите начальную станцию из списка"
    show_collection(@stations)
    first_station = select_from_collection(@stations)
    puts "Укажите конечную станцию из списка"
    show_collection(@stations)
    last_station = select_from_collection(@stations)
    return if first_station.nil? || last_station.nil?
    return if first_station == last_station
    @routes << Route.new(first_station,last_station)
    puts "Вы добавили маршрут c #{first_station.name} до #{last_station.name}"
  end


  def assign_route
    puts "Назначить маршрут поезду"
    puts "--------------------------------------------------"
    puts "Выберите поезд указав из списка"
    show_collection(@trains)
    train = select_from_collection(@trains)
    puts "Выберите маршрут из списка"
    show_collection(@routes)
    route = select_from_collection(@routes)
    train.accept_route(route)
    puts "Поезду #{train.number} присвоен маршрут #{route.first_station.name} - #{route.last_station.name}"
  end
  
  def add_transit_station
    puts "Добавьте транзитную станцию в маршрут из списка"
    puts "Выберите маршрут"
    show_collection(@routes)
    route = select_from_collection(@routes)
    puts "Добавьте транзитную станцию для маршрута"
    show_collection(@stations)
    transit_station = select_from_collection(@stations)
    route.transit_station_add(transit_station)
    puts "Транзитная станция #{transit_station.name} добавлена"
  end

  def train_controller
    puts "Чтобы управлять поездом, укажите индекс поезда"
    show_collection(@trains)
    train = select_from_collection(@trains)
    puts "Выберите направление движения: 1 - вперед, 2 - назад"
    line = gets.to_i
    case line
    when 1
      train.go_next
      puts "Текущая станция: #{train.current_station}"
    when 2
      train.go_back
      puts "Текущая станция: #{train.current_station}"
    end
  end 


  def show_list
    puts "*Список станций:"
    show_collection(@stations)
    puts "*Список поездов:"
    show_collection(@trains)
    puts "*Список маршрутов"
    show_collection(@routes)
    puts "*Список вагонов:"
    show_collection(@wagons)
  end  

  def show
    @trains.each do |train|
      puts "Количество вагонов у #{train.type} у поезда №#{train.number}:"
      wagons = train.wagons
      num = wagons.count
      puts "#{num}"
      train.wagon_search {|wagon|  wagon = wagon.busy_volume; puts "Занятых мест в вагоне #{wagon}"}
      train.wagon_search {|wagon|  wagon = wagon.free_volume; puts "Свободных мест в вагоне #{wagon}"}
    end

      
    @stations.each do |station|
      puts "Поезда на станции #{station.name}:"
      station.train_search {|train| puts train}
    end
  end

  def show_collection(collection)
    collection.each.with_index(1) do |name, index|
    puts "#{index} - #{name}"
    end
  end

  def select_from_collection(collection)
    index = gets.to_i - 1
    return if index.negative?
    collection[index]
  end

end

new_session = Main.new
new_session.choice