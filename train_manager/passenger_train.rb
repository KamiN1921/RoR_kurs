class PassengerTrain < Train
  include InstanceCounter
  TYPE = 'пассажирский'
  def add_cargo
    @cars.push(PassengerTrainCar.new) if stopped?
  end

end