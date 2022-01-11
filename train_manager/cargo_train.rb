# frozen_string_literal: true

class CargoTrain < Train
  include InstanceCounter
  TYPE = 'грузовой'
  MESSAGE ='Введите количество грузового места'
  validate "@number", 'presence'
  validate "@number", 'format',/^((\d|[a-zA-Z]|[а-яА-Я]){3}-?(\d|[a-zA-Z]|[а-яА-Я]){2})$/

  def type
    TYPE
  end
  def mess
    MESSAGE
  end

  def add_train_car(space)
    @cars.push(CargoTrainCar.new(space)) if stopped?
  end
end
