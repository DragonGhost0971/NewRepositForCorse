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
    route.start.take_of_the_train(self)

  end

  def next_one
    @route.travel[1].take_of_the_train(self)
    @route.travel[0].delete_the_train(self)
  end

  def back_one
  	@route.travel[0].take_of_the_train(self)
    @route.travel[1].delete_the_train(self)
  end
  def view_routs
  puts @route.travel.each

  end
end

class Station
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

  def show_trains
    @trains.each { |train| puts train }
  end

  def type_train(type)
    @trains.each do |train|
      puts train if type == train.type
    end
  end
end

class Route
  attr_reader :start, :travel

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

  def list_route
    @travel.each { |station| puts station.name_station }
  end
end
