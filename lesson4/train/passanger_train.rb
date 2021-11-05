class PassangerTrain < Train
  
  def initialize(number)
    @type = :passenger
    super
  end

  def attachable_wagon?(wagon)
    self.type == wagon.type
  end
  
end