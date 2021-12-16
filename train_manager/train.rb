class Train
  include Manufacturer

  attr_reader :number
  attr_reader :TYPE
  attr_reader :velocity
  attr_reader :route
  attr_reader :current_station_index
  @@all_trains = []
  NUMBER_REGEX = /^(([\d]|[a-zA-Z]|[а-яА-Я]){3}-?([\d]|[a-zA-Z]|[а-яА-Я]){2})$/

  def valid?
    raise "Некорректно введен номер" unless number =~ NUMBER_REGEX
    raise "Неустановлено количество вагонов поезда" if @cars.length<1
    true
  end

  def self.find(number)
    @@all_trains.find{|train| train.number == number}
  end

  def each_train_car(&block)
    @cars.each { |car| block.call(car)}
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

  def add_train_car(spaceincar)
  end

  def initialize(number,count_of_cars, &block) #  внутренний механизм
    @current_station_index = -1
    @number = number.to_s
    @velocity = 0
    @cars = []
    register_instance
    while @cars.length<count_of_cars
      space = block.call
      add_train_car(space)
    end
    begin
    valid?
    rescue StandardError=>e
      raise "Некорректно заданый объект: #{e.message}"
    else
    @@all_trains<<self
    end
  end

  def accelerate(speed) #будет использоаться в дочернем классе
    @velocity+=speed
  end

  def stop # будет использоаться в дочернем классе
    @velocity = 0
  end
end