class Train
  protected #все методы будут унаследованы для дочерних классов, но работать напрямую с классом "поезд" мы не будем
  attr_reader :velocity #для работы со скоростью у нас есть методы
  def initialize(number) #  внутренний механизм но наследуется
    @current_station = 0
    @number = number.to_s
    @velocity =0
    @cars = []
  end
  attr_reader :number #нужный для окружающих параметр
  def accelerate #внешний интерфейс, будет использоаться в дочернем классе
    @velocity+=1
  end

  def stop #внешний интерфейс, будет использоаться в дочернем классе
    @velocity = 0
  end

  def take_route(route) #внешний интерфейс, будет использоаться в дочернем классе
    @route = route
    @route.stations.first.train_arrival(self)
    @current_station = 1
  end

  def next_station #внешний интерфейс, будет использоаться в дочернем классе
    if @route.nil?
      puts "No route! We can't!"
    elsif @route.stations.length <= @current_station
      puts "No next stations in route. Please give us new route"
    else
      @route.stations[@current_station-1].train_departure(@number)
      @current_station+=1
      @route.stations[@current_station-1].train_arrival(self)
    end
  end

  def prev_station #внешний интерфейс, будет использоаться в дочернем классе
    if @route.nil?
      puts "No route! We can't!"
    elsif @current_station == 0 || @current_station == 1
      puts "No previous stations in route. Please give us new route"
    else
      @route.stations[@current_station-1].train_departure(@number)
      @current_station-=1
      @route.stations[@current_station-1].train_arrival(self)
    end
  end

  def pop_train_car
    @cars.pop
  end
end