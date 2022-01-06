# frozen_string_literal: true

class PassengerTrainCar < TrainCar
  include InstanceCounter
  extend Accessors
  include Validation
  attr_reader :TYPE

  def validateobj
    self.class.validate @space, 'presence'
    self.validate!
  end

  TYPE = 'пассажирский'

  def take_seat
    raise 'Недостаточно места' unless free_space.positive?

    @taken_space += 1
  end

  protected

  def initialize(space)
    super
    validateobj
    @number = self.class.instances
  end
end
