class PassangerCarriage < Carriage
  attr_reader :type

  def initialize
    super
    @type = 'pass'
  end
end
