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
    puts "ПАНЕЛЬ УПРАВЛЕНИЯ ЖЕЛЕЗНОДОРОЖНОЙ СТАНЦИЕЙ"
    puts "*********************************************"
    puts "Выберите соответствующий номер для выполнения"
    puts "1. Создать станцию"
    puts "2. Создать поезд"
    puts "3. Создать маршрут"
    puts "4. Назначить маршрут поезду"
    puts "5. Создать вагон"
    puts "6. Добавить вагон к поезду"
    puts "7. Отцепить вагон от поезда"
    puts "8. Управление поездом"
    puts "9. Посмотреть список вагонов у поезда"   
    puts "10. Посмотреть список поездов на станции" 
    puts "11. Занять место или обьем в вагоне"
    #puts "9. Просмотреть список станции и поездов на станции"
    puts "0. Чтобы выйти с программы"
    puts "**************************************************"
    show_list
  end

  def choice
    loop do 
      menu
      choice = gets.to_i
      case choice
      when 1 then create_station
      when 2 then create_train
      when 3 then create_route
      when 4 then assign_route
     # when 5 then create_wagon
      when 6 then attach_wagon_controller
      when 7 then detach_wagon_controller
      when 8 then train_controller
      when 9 then train_wagons
      when 10 then train_at_station
      when 11 then take_place_or_volume
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
    rescue => e
      puts e.inspect
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
  end


  #def create_wagon
   # puts "Выберите тип создаваемого вагона: 1 - Пассажирский, 2 - Грузовой"
    #wagons = gets.to_i
    #case wagons
    #when 1
     # puts "Укажите количество посадочных мест:"
      #number_of_seats = gets.to_i
      #@wagons << PassangerWagon.new(number_of_seats)
    #when 2
     # puts "Укажите обьем грузового вагона:"
      #volume = gets.to_i
      #@wagons << CargoWagon.new(volume)
     #end
  #end

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
  end

  def attach_wagon_controller
    puts "Чтобы прицепить вагон к поезду выберите индекс"
    show_collection(@trains)
    train = select_from_collection(@trains)
    puts "Выберите типа вагона: 1- Пассажирский или 2 - Грузовой"
    wagons = gets.to_i
    case wagons
    when 1
      puts "Уажите количество мест пассажирского вагона:"
      number_of_seats = gets.to_i
      train.attach_wagons(PassangerWagon.new(number_of_seats))
      p train
    when 2
      puts "Уажите обьем грузового вагона:"
      volume = gets.to_i
      train.attach_wagons(CargoWagon.new(volume))
      p train
    end
  end

  def detach_wagon_controller
    puts "Чтобы оцепить вагон от поезда выберите индекс" 
    show_collection(@trains)
    train = select_from_collection(@trains)
    puts "Выберите вагон который хотите оцепить"
    show_collection(train.wagons)
    wagon = gets.to_i
    train.detach_wagons(train.wagons[wagon])
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

 #Выводить список вагонов у поезда (#кол-во мест или общий объем), используя созданные методы
  def train_wagons
    puts "Выберите поезд у которого хотите посмотреть список вагонов"
    show_collection(@trains)
    train = select_from_collection(@trains)
    if train.type == :cargo 
      train.free_volume
    end
  end
  
 #Выводить список поездов на станции (#кол-во мест или общий объем), используя  созданные методы
 # def train_at_station
   #puts "Выберите вагон который хотите оцепить"
    #show_collection(train.wagons)
    #wagon = gets.to_i
    #train.detach_wagons(train.wagons[wagon])
  #end

 # Занимать место или объем в вагоне
  #def take_place_or_volume
   # puts "Выберите вагон в котором хотите занять место"
   # show_collection(@wagons)
    #select_from_collection(@wagons)

  #end


  def show_list
    puts "Список станций:"
    show_collection(@stations)
    puts "Список поездов:"
    show_collection(@trains)
    puts "Список маршрутов"
    show_collection(@routes)
    puts "Список вагонов:"
    show_collection(@wagons)
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

