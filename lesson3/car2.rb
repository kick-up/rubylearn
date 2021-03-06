
class Car
  attr_accessor :color #“Может возвращать цвет, может менять цвет”
  attr_reader :number, :door_tittle #“Может возвращать надпись на двери”
  #:drivers  #“Знает имена, допущенных к управлению водителей”

  def initialize(number) #“Имеет номер, который указывается при создании”
    @number = number
    @color = 'white' #“Имеет цвет, при создании цвет устанавливается в значение ‘white’”
    # @drivers = []
  end

  def beep #“Может выводить в консоли ‘beep beep’”
    puts 'beep beep'
  end

  #def add_driver(name) #“Может добавлять имена водителей в список имен водителей”
    #@drivers << name
  #end

   #def add_driver(driver) #Может добавлять водителей в список водителей
    #@drivers << driver
  #end

  #def show_drivers    #“Может выводить список имен водителей”
    #@drivers.each {|driver| puts driver.name} #мы перебираем элементы, каждый из которых - объект класса Driver
  #end
  
  def change_door_title(driver) #“Может устанавливать надпись на двери в значение равное имени владельца”
    @door_tittle = driver.name if driver.cars.include?(self)
  end
#благодаря проверке, касающейся “владения автомобилем”, надпись на двери изменится тогда и только тогда, 
#когда переданный в метод объект (водитель) является владельцем текущего авто (внутри метода переменная self ссылается на объект класса Car, 
#у которого этот метод был вызван)
#другими словами:
#автомобиль у которого вызван метод change_door_title должен находится в списке @cars у водителя, имя которого мы хотим нанести на дверь

end


class Driver
  attr_reader :cars :name #“Может возвращать имя” #Может возвращать список автомобилей, которыми владеет”

  def initialize(name) #Имеет имя, которое указывается при создании”
    @name = name
    @cars = []
  end
#он должен означать, что объект класса Driver, видимо должен хранить инстанс-переменную @cars (“владеть автомобилями”) 
#и в классе должен быть метод buy_car, который будет добавлять автомобили в список автомобилей, которыми “владеет водитель”
#здесь нужно обратить внимание на то, что в списке, т.е. в переменной, которая хранит в себе коллекцию (массив в нашем случае), 
#должны храниться не номера автомобилей, а объекты класса Car (точнее ссылки на эти объекты)

  def buy_car(car) #“Может покупать и владеть автомобилями” ?
    @cars << car
    car.change_door_title(self)
  end
end

#При покупке нового автомобиля наносит на его дверь свое имя”
#в методе buy_car (в классе Driver) объект класса Car, переданный в метод, должен быть изменен
#а именно, должно измениться содержание инстанс-переменной @door_title
#для этого у нас в классе Car есть метод change_door_title




