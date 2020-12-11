class PassangerCarriage < Carriage
  attr_reader :type, :number_of_place_taken, :number_free_place

  def initialize(number_of_seats)
    @type = 'pass'
    @number_of_seats = number_of_seats # Число мест
    @number_of_place_taken = 0 # Занятые места
    @number_free_place = number_of_seats # Свободных мест
  end

  def to_take_seats(volume)
    @number_of_place_taken = volume
    @number_free_place = @number_of_seats - @number_of_place_taken
  end
end
