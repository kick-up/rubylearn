class Car
  attr_reader :current_rpm
  attr_accessor :number

  NUMBER_FORMAT = /^[a-q]{1}\d{3}[a-q]{2}$/i

  def initialize(number)
    @number = number
    @current_rpm = 0
    validate!
  end
    
  def start_engine  
   start_engine! if engine_stopped?
  end

  def engine_stopped?
    current_rpm.zero?
  end

  def valid?
    validate!
  rescue 
    false
  end

  protected

  def validate!
    errors = []
    errors << "Number is nil" if number.nil?
    errors << "Number 6 simbol" if number.length < 6 
    errors << "Number format" if number !~ NUMBER_FORMAT
    true
    raise errors.join(";") unless errors.empty?
  end

  attr_writer :current_rpm
  
  def initial_rpm
    700
  end

  def start_engine!
    self.current_rpm = initial_rpm
  end

end