class CargoTrain < Train

  def initialize(number)
    @type = :cargo
    super
  end

  def attachable_wagon?(wagon)
    self.type == wagon.type
  end
  
end