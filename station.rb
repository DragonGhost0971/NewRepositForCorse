require_relative 'modules'

class Station
  include InstanceCounter
  attr_reader :trains, :name_station

  def self.all
    @@stations
  end

  @@stations = []

  def initialize(name_station)
    @name_station = name_station
    @trains = []
    @@stations.push(self)
    register_instance
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

  def block_carriage
    @trains.each do |train|
      yield(train) if block_given?
    end
  end
end
