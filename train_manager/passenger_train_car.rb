# frozen_string_literal: true

class PassengerTrainCar < TrainCar
  include InstanceCounter
  extend Accessors
  include Validation
  attr_reader :TYPE
  validate "@space", 'positive'

  TYPE = 'пассажирский'

  def take_seat
    raise 'Недостаточно места' unless free_space.positive?

    @taken_space += 1
  end

  protected

  def initialize(space)
    super
    validate!
    @number = self.class.instances
  end
end
