class PassengerTrain < Train
  def initialize(number)
    @number = number
    @carriage = []
  end

  def add_pass_carriage(coach)
    @carriage << coach
  end

  def del_carriage
    @carriage.delete_at(-1)
  end
end
