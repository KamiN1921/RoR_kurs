class PassengerTrainCar<TrainCar
  include InstanceCounter

  attr_reader :taken_seats
  attr_reader :seats

  TYPE = "пассажирский"

  def type
    TYPE
  end

  def take_seat
    raise "Недостаточно места" unless free_space > 0
    @taken_seats +=1
  end

  def free_space
    @seats - @taken_seats
  end

  protected

  def initialize(count_of_seats)
    super
    @seats = count_of_seats
    @taken_seats = 0
    @number = self.class.instances
  end

end