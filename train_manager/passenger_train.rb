# frozen_string_literal: true

class PassengerTrain < Train
  include InstanceCounter
  TYPE = 'пассажирский'

  def type
    TYPE
  end

  def add_train_car(seats)
    @cars.push(PassengerTrainCar.new(seats)) if stopped?
  end
end
