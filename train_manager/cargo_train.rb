class CargoTrain < Train
  include InstanceCounter
  TYPE = 'грузовой'
  def add_train_car
    @cars.push(CargoTrainCar.new) if stopped?
  end
end