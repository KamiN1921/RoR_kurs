class TrainCar
  include InstanceCounter
  include Manufacturer

  attr_reader :TYPE
  attr_reader :number
  attr_reader :taken_space
  attr_reader :space

  def free_space
    @space - @taken_space
  end

  def type
    TYPE
  end

  def initialize(x)
    register_instance
  end
end