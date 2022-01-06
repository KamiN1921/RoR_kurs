# frozen_string_literal: true

class CargoTrainCar < TrainCar
  include InstanceCounter
  include Validation
  attr_reader :TYPE

  def validateobj
    self.class.validate @space, 'presence'
    self.validate!
  end

  TYPE = 'грузовой'

  def take_space(value)
    raise 'Недостаточно места' if free_space < value

    @taken_space += value
  end

  protected

  def initialize(space)
    super
    validateobj
    @number = self.class.instances
  end
end
