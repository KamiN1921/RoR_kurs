# frozen_string_literal: true

class PassengerTrainCar < TrainCar
  include InstanceCounter
  attr_reader :TYPE

  TYPE = 'пассажирский'

  def take_seat
    raise 'Недостаточно места' unless free_space.positive?

    @taken_space += 1
  end

  protected

  def initialize(space)
    super
    @number = self.class.instances
  end
end
