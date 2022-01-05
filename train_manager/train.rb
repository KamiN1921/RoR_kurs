# frozen_string_literal: true

class Train
  include Manufacturer
  include Validation

  attr_reader :number, :TYPE, :velocity, :route, :current_station_index

  @@all_trains = []
  NUMBER_REGEX = /^((\d|[a-zA-Z]|[а-яА-Я]){3}-?(\d|[a-zA-Z]|[а-яА-Я]){2})$/.freeze

  def self.find(number)
    @@all_trains.find { |train| train.number == number }
  end

  def each_train_car(&block)
    @cars.each { |car| block.call(car) }
  end

  def count_of_cars
    @cars.length
  end

  # будет вызываться напрямую
  def pop_train_car
    @cars.pop unless @cars.empty?
  end

  # внешний интерфейс, будет использоваться пользователями
  def take_route(route)
    @route = route
    @route.stations.first.train_arrival(self)
    @current_station_index = 0
  end

  # внешний интерфейс, будет использоваться пользователями
  def next_station
    @route.stations[@current_station_index].train_departure(@number)
    @current_station_index += 1
    @route.stations[@current_station_index].train_arrival(self)
  end

  # внешний интерфейс, будет использоваться пользователями
  def prev_station
    @route.stations[@current_station_index].train_departure(@number)
    @current_station_index -= 1
    @route.stations[@current_station_index].train_arrival(self)
  end

  # внешний интерфейс, будет использоваться пользователями
  def stopped?
    @velocity.zero?
  end

  protected # все методы будут унаследованы для дочерних классов, но работать напрямую с ними мы не будем

  def add_train_car(spaceincar); end

  #  внутренний механизм
  def initialize(number, count_of_cars, &block)
    @current_station_index = -1
    @number = number.to_s
    @velocity = 0
    @cars = []
    register_instance
    while @cars.length < count_of_cars
      space = block.call
      add_train_car(space)
    end
    begin
      self.class.validate number, 'presence'
      self.class.validate number, 'format', NUMBER_REGEX
      validate!
    rescue StandardError => e
      raise "Некорректно заданый объект: #{e.message}"
    else
      @@all_trains << self
    end
  end

  # будет использоаться в дочернем классе
  def accelerate(speed)
    @velocity += speed
  end

  # будет использоаться в дочернем классе
  def stop
    @velocity = 0
  end
end
