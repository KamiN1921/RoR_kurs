# frozen_string_literal: true

class PassengerTrain < Train
  extend Accessors
  include InstanceCounter
  TYPE = 'пассажирский'
  MESSAGE ='Введите количество сидячих мест'
  validate "@number", 'presence'
  validate "@number", 'format',/^((\d|[a-zA-Z]|[а-яА-Я]){3}-?(\d|[a-zA-Z]|[а-яА-Я]){2})$/

  def type
    TYPE
  end
  def mess
    MESSAGE
  end

  def add_train_car(seats)
    @cars.push(PassengerTrainCar.new(seats)) if stopped?
  end
end
