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
