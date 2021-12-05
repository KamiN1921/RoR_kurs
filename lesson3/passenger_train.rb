class PassengerTrain < Train
  attr_reader :TYPE
  attr_reader :number
  TYPE = 'пассажирский'
  def add_train_car(car)
    @cars.push(car) if stopped?&&(car.is_a? PassengerTrainCar)
  end

  def pop_train_car
    super
  end
  def take_route(roure)
    super roure
  end
  def next_station
    super
  end
  def prev_station
    super
  end

end