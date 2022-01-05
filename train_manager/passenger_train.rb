# frozen_string_literal: true

class PassengerTrain < Train
  extend Accessors
  include InstanceCounter
  TYPE = 'пассажирский'

  def type
    TYPE
  end

  def add_train_car(seats)
    @cars.push(PassengerTrainCar.new(seats)) if stopped?
  end
end
