require_relative 'modules'
class Route
  include InstanceCounter
  attr_reader :stations, :finish, :start

  def initialize(start, finish)
    @start = start
    @finish = finish
    @stations = [@start, @finish]
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def del_station(station)
    @stations.delete(station)
  end
end
