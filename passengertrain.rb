class PassangerTrain < Train
  attr_reader :type

  def initialize(namber)
    super
    @type = 'pass'
  end
end
