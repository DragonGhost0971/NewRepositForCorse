class CargoTrain < Train
  def initialize(number)
    @number = number
    @carriage = []
  end

  def add_carriage(cariagee)
    @carriage << cariagee
  end

  def del_carriage
    @carriage.delete_at(-1)
  end
end
