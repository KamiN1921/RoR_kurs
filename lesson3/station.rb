class Station
  attr_reader :name
  attr_reader :trains
  def initialize(name)
    @trains=[]
    @name = name
  end
  def train_arrival (train)
    if !(@trains.find_all{ |element| element.number == train.number }.empty?)
      puts "This station already has this train"
    else
      @trains << train
    end

  end
  def get_trains_by_type (type)
    case type
    when "passenger"
      @trains.find_all{ |train| train.is_a? PassengerTrain}
    when "cargo"
      @trains.find_all{ |train| train.is_a? == CargoTrain}
    else
      puts "Undefined type"
    end
  end

  def train_departure(number)
    @trains.delete_if{|train| train.number == number}
  end

end