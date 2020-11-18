class CargoTrain < Train
  attr_reader :type

  def initialize(namber)
    super
    @type = 'cargo'
  end
end
