class CargoTrainCar<TrainCar
  include InstanceCounter

  attr_reader :taken_space
  attr_reader :space
  TYPE = "грузовой"

  def type
    TYPE
  end

  def take_space(v)
    raise "Недостаточно места" if free_space < v
    @taken_space +=v
  end

  def free_space
    @space - @taken_space
  end
  protected

  def initialize(space)
    super
    @space = space
    @taken_space = 0
    @number = self.class.instances

  end


end