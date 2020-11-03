class Train
  def initialize
  	@nameber = nameber
  	@type = type
  	@nameber_of_cars
  end

  def speed
  	@speed = 50
  end

  def currrent_speed
  	puts "currrent_speed: #{@speed}"
  end

  def stop
  	@speed = 0
  end

  def namber_of_cars
  	puts "number of cars: #{nameber_of_cars}"
  end

  def add_car
  	if @speed == 0
  		@namber_of_cars +=1
  	puts "add car"
  end
  
  end