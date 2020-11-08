class Train
  attr_reader :speed, :number_of_cars, :route, :type

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

  def route(route)
    @route = route
    @route.start.add_train(self)
    @current_station = @route.start
  end

  def next_station
    @route.stations[@route.stations.index(@current_station) + 1] unless @current_station == @route.finish
  end

  def previous_station
    @route.stations[@route.stations.index(@current_station) - 1] unless @current_station == @route.start
  end

  def move_forward
    return unless next_station
    @current_station.delete_train(self)
    @current_station = next_station
    @current_station.add_train(self)
  end

  def move_backward
  	return unless previous_station
  	@current_station.delete_train(self)
    @current_station = next_station
    @current_station.add_train(self)
  end

end

class Station
  attr_reader :trains

  def initialize(name_station)
    @name_station = name_station
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def del_train(train)
    @trains.delete(train)
  end

  def type_train(type)
    @trains.filter { |train| type == train.type }
  end
end

class Route
  attr_reader :stations, :finish, :start

  def initialize(start, finish)
    @start = start
    @finish = finish
    @stations = [@start, @finish]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def del_station(station)
    @stations.delete(station)
  end
end
