class CargoTrain < Train
  include InstanceCounter
  TYPE = 'грузовой'
  def add_cargo
    @cars.push(CargoTrainCar.new) if stopped?
  end
end