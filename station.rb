class Station
  attr_reader :trains, :name_station

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
