class PassangerTrain < Train
  
  def initialize(number)
    @type = "Пассажирский"
    super
  end

  def attachable_wagon?(wagon)
    wagon.is_a?(PassangerWagon)
  end
  
end