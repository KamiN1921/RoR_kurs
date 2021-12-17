class PassengerTrainCar<TrainCar
  include InstanceCounter
  attr_reader :TYPE

  TYPE = "пассажирский"

  def take_seat
    raise "Недостаточно места" unless free_space > 0
    @taken_space+=1
  end

  protected

  def initialize(count_of_seats)
    super
    @space = count_of_seats
    @taken_space = 0
    @number = self.class.instances
  end

end