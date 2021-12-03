class Station
  attr_reader :trains
  attr_reader :name
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
    if Train.types.key?(type) || Train.types.value?(type)
    end
    @trains.find_all{ |train| train.type == type}
  end

  def train_departure(number)
    @trains.delete_if{|train| train.number == number}
  end

end