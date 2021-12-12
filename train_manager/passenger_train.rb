class PassengerTrain < Train
  include InstanceCounter
  TYPE = 'пассажирский'
  def add_train_car
    @cars.push(PassengerTrainCar.new) if stopped?
  end

end