class TrainCar
  include InstanceCounter
  include Manufacturer

  attr_reader :TYPE
  attr_reader :number

  def initialize(x)
    register_instance
  end
end