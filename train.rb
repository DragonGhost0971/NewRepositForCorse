class Train
  attr_reader :speed, :type, :number_of_cars, :route

  def initialize(number, type, number_of_cars)
    @number = number
    @type = type
    @number_of_cars = number_of_cars
  end

  def go
    @speed = 60
  end

  def stop
    @speed = 0
  end

  def attach_a_car
    @number_of_cars += 1 if @speed == 0
  end

  def uncouple_a_car
    @number_of_cars -= 1 if @speed == 0
  end

  def routes(route)
    @route = route
    @route.start.take_of_the_train(self)
    @ind = 0
  end

  def next_one
    @route.travel[@ind+1].take_of_the_train(self)
    @route.travel[@ind].delete_the_train(self)
    @ind+=1
  end

  def back_one
  	@route.travel[@ind-1].take_of_the_train(self)
    @route.travel[@ind].delete_the_train(self)
    @ind-=1
  end
  def view_routs
  puts "next #{@route.travel[ind+1]}"
  puts "now #{@route.travel[@ind]}"
  puts "back #{@route.travel[ind-1]}"
  end
end

class Station
attr_reader :trains

  def initialize(name_station)
    @name_station = name_station
    @trains = []
  end

  def take_of_the_train(train)
    @trains << train
  end

  def delete_the_train(train)
    @trains.delete(train)
  end

  def type_train(type)
    @trains.each { |train| puts train if type == train.type}
  end
end

class Route
attr_reader :travel, :start

  def initialize(start, finish)
    @start = start
    @finish = finish
    @travel = [start, finish]
  end

  def add_station(station)
    @travel.delete_at(-1)
    @travel << station
    @travel << @finish
  end

  def del_station(station)
    @travel.delete(station)
  end
end
