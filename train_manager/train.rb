class Train
  include Manufacturer

  attr_reader :number
  attr_reader :TYPE
  attr_reader :velocity
  attr_reader :route
  attr_reader :current_station_index
  @@all_trains = []

  def self.find(number)
    @@all_trains.find{|train| train.number == number}
  end

  def count_of_cars
    @cars.length
  end

  def pop_train_car #будет вызываться напрямую
    @cars.pop unless @cars.empty?
  end

  def take_route(route) #внешний интерфейс, будет использоваться пользователями
    @route = route
    @route.stations.first.train_arrival(self)
    @current_station_index = 0
  end

  def next_station #внешний интерфейс, будет использоваться пользователями
    @route.stations[@current_station_index].train_departure(@number)
    @current_station_index+=1
    @route.stations[@current_station_index].train_arrival(self)
  end

  def prev_station #внешний интерфейс, будет использоваться пользователями
    @route.stations[@current_station_index].train_departure(@number)
    @current_station_index-=1
    @route.stations[@current_station_index].train_arrival(self)
  end

  def stopped? #внешний интерфейс, будет использоваться пользователями
    @velocity==0
  end

  protected #все методы будут унаследованы для дочерних классов, но работать напрямую с ними мы не будем

  def add_cargo
  end

  def initialize(number,count_of_cars) #  внутренний механизм
    @current_station_index = -1
    @number = number.to_s
    @velocity = 0
    @cars = []
    register_instance
    while @cars.length<count_of_cars
      add_cargo
    end
    @@all_trains<<self
  end

  def accelerate(speed) #будет использоаться в дочернем классе
    @velocity+=speed
  end

  def stop # будет использоаться в дочернем классе
    @velocity = 0
  end
end