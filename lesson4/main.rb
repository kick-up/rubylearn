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
  end

   TRAIN_TYPES = [PassangerTrain, CargoTrain]


  def menu
    puts "---------------------------------------------"
    puts "Панель управления железнодорожной станцией"
    puts "---------------------------------------------"
    puts "Выберите соответствующий номер для выполнения"
    puts "1. Создать станцию"
    puts "2. Создать поезд"
    puts "3. Создать маршрут"
    puts "4. Назначить маршрут поезду"
    puts "5. Добавить вагон к поезду"
    puts "6. Отцепить вагон от поезда"
    puts "7. Управление поездом"
    puts "8. Просмотреть список станции и поездов на станции"
    puts "--------------------------------------------------"
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
      when 5 then attach_carriage_controller
      when 6 then detach_carriage_controller
      when 7 then train_controller
      when 8 then show_assets
      end
    end
  end


  def create_station  
    puts "Введите название станции:"
    new_station = gets.chomp.capitalize!
    @stations << Station.new(new_station)
    puts "Вы добавили станцию #{new_station}"
  end

  def create_train
    puts "Выберите тип создаваемого поезда: 1 - Пассажирский, 2 - Грузовой"
    train_type = select_from_collection(TRAIN_TYPES)
    puts "Укажите номер поезда"
    train_number = gets.chomp
    @trains << train_type.new(train_number)
  end


  def create_route

  

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

  def show_list
    puts "Список станций:"
    show_collection(@stations)
    puts "Список поездов:"
    show_collection(@trains)
    puts "Список маршрутов"
    show_collection(@routes)
  end


end

new_session = Main.new
new_session.choice