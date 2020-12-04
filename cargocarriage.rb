class CargoCarriage < Carriage
  attr_reader :type, :to_fill_volume, :free_volume

  def initialize(volume)
    @type = 'cargo'
    @volume = volume # Число мест
    @to_fill_volume = 0 # Занятый объём
    @free_volume = volume # Свободный объём
  end

  def to_fill(vol)
    @to_fill_volume = @free_volume - vol
    @free_volume = @volume - @to_fill_volume
  end
end
