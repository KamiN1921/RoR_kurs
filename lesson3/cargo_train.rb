class CargoTrain < Train
  def add_train_car(car)
    @cars.push(car) if car.is_a? CargoTrainCar
  end

end