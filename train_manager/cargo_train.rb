class CargoTrain < Train
  include InstanceCounter
  TYPE = "грузовой"

  def type
    TYPE
  end

  def add_train_car(space)
    @cars.push(CargoTrainCar.new(space)) if stopped?
  end
end