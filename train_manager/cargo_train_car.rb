# frozen_string_literal: true

class CargoTrainCar < TrainCar
  include InstanceCounter
  attr_reader :TYPE

  TYPE = 'грузовой'

  def take_space(value)
    raise 'Недостаточно места' if free_space < value

    @taken_space += value
  end

  protected

  def initialize(space)
    super
    @number = self.class.instances
  end
end
