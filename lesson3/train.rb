class Train

  protected #все методы будут унаследованы для дочерних классов, но работать напрямую с ними мы не будем
  attr_reader :number #нужный для окружающих параметр

  def pop_train_car #будет вызываться напрямую
    @cars.pop unless @cars.empty?
  end

  def take_route(route) #внешний интерфейс, будет использоваться пользователями
    @route = route
    @route.stations.first.train_arrival(self)
    @current_station = 1
  end

  def next_station #внешний интерфейс, будет использоваться пользователями
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

  def prev_station #внешний интерфейс, будет использоваться пользователями
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

  def stopped? #внешний интерфейс, будет использоваться пользователями
    @velocity==0
  end

  attr_reader :velocity #для работы со скоростью у нас есть методы
  def initialize(number) #  внутренний механизм
    @current_station = 0
    @number = number.to_s
    @velocity =0
    @cars = []
  end

  def accelerate #будет использоаться в дочернем классе
    @velocity+=1
  end

  def stop # будет использоаться в дочернем классе
    @velocity = 0
  end
end