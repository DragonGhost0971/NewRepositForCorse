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
    @route.start.take_of_the_train(self)
    @finish = @route.stations.size
    @finish =-1
    @station_now = 0
  end

  def next_one
  	unless @station_now != 0
      @route.stations[@station_now+1].take_of_the_train(self)
      @route.stations[@station_now].delete_the_train(self)
      @station_now=+1
    end
  end

  def back_one
  	if @station_now != @finish && @station_now != 0
  	  @route.stations[@station_now-1].take_of_the_train(self)
      @route.stations[@station_now].delete_the_train(self)
   	  @station_now=@station_now - 1
    end
  end
  def view_next_station
	  @route.stations[@station_now+1]
  end
  def view_back_station
  	  @route.stations[@station_now-1]
  end
  def view_now_station[@]
  	  @route.stations[@station_now]
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
    @trains.filter {|train| type == train.type}
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

