class CargoTrainCar<TrainCar
  include InstanceCounter
  attr_reader :TYPE

  TYPE = "грузовой"

  def take_space(v)
    raise "Недостаточно места" if free_space < v
    @taken_space +=v
  end

  protected

  def initialize(space)
    super
    @number = self.class.instances
  end

end