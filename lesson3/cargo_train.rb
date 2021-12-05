class CargoTrain < Train
  attr_reader :number
  attr_reader :TYPE
  TYPE = 'грузовой'
  def add_train_car(car)
    @cars.push(car) if stopped?&&(car.is_a? CargoTrainCar)
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