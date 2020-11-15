class Train
  attr_reader :speed, :route

  def initialize(number)
    @number = number
    @carriage = []
  end

  def go
    @speed = 60
  end

  def stop
    @speed = 0
  end

  def add_carriage(cariagee)
    @carriage << cariagee
  end

  def del_carriage
    @carriage.delete_at(-1)
  end

  def route_for_train(route)
    @route = route
    @route.start.add_train(self)
    @current_station = @route.start
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

  def next_station
    @route.stations[@route.stations.index(@current_station) + 1] unless @current_station == @route.finish
  end

  def previous_station
    @route.stations[@route.stations.index(@current_station) - 1] unless @current_station == @route.start
  end
end
