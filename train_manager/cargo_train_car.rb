# frozen_string_literal: true

class CargoTrainCar < TrainCar
  include InstanceCounter
  include Validation
  attr_reader :TYPE
  validate "@space", 'positive'


  TYPE = 'грузовой'

  def take_space(value)
    raise 'Недостаточно места' if free_space < value
    @taken_space += value
  end

  protected

  def initialize(space)
    super
    validate!
    @number = self.class.instances
  end
end
