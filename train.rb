class Train
	def initialize(number,type,number_of_cars)
		@number = number
		@type = type
		@number_of_cars = number_of_cars
	end

	def speed
		@speed = 60
	end

	def currrent_speed
		puts "currrent_speed: #{@speed}"
	end

	def stop
		@speed = 0
	end

	def number_of_cars
		@number_of_cars
	end

	def add_car
		if @speed == 0
			@number_of_cars+=1
		end
	end

	def minus_car
		if @speed == 0
			@number_of_cars-=1
		end
	end
	
end