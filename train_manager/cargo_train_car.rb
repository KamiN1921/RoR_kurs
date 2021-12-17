class CargoTrainCar<TrainCar
  include InstanceCounter

  TYPE = "грузовой"

  def take_space(v)
    raise "Недостаточно места" if free_space < v
    @taken_space +=v
  end

  protected

  def initialize(space)
    super
    @space = space
    @taken_space = 0
    @number = self.class.instances
  end


end