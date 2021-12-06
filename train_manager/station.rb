class Station
  attr_reader :name
  attr_reader :trains

  def initialize(name)
    @trains=[]
    @name = name
  end
  def train_arrival (train)
      @trains << train
  end

  def get_trains_by_type (type)
    case type
    when "passenger"
      @trains.find_all{ |train| train.is_a? PassengerTrain}
    when "cargo"
      @trains.find_all{ |train| train.is_a? CargoTrain}
    else
    end
  end

  def train_departure(number)
    @trains.delete_if{|train| train.number == number}
  end

end