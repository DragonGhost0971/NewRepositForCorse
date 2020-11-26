require_relative 'modules'

class Train
  include InstanceCounter
  include NameCompany
  attr_reader :speed, :route, :number

  def self.find(num)
    @@trains.filter { |train| num == train.number }
  end

  @@trains = []

  def initialize(number)
    @number = number
    @carriage = []
    @@trains.push(self)
    register_instance
    validate!
  end

  NAMBER_FORMAT = /^[\w\d]{3}-*[\w\d]{2}$/i.freeze

  def go
    @speed = 60
  end

  def stop
    @speed = 0
  end

  def add_carriage(train, carriage)
    @carriage << carriage if train.type == carriage.type
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

  protected

  def validate!
    raise 'Неверный формат номера' if @number !~ NAMBER_FORMAT
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end
