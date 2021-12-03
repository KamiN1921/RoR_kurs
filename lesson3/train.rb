class Train
  attr_reader :velocity
  attr_reader :count
  attr_reader :number
  attr_reader :type

  def self.types
    @@types
  end
  @@types = {"1"=> "пассажирский", "2" => "грузовой"}

  def initialize(number,type,count)
    @current_station = 0
    @number = number.to_s
    @count = count.to_i
    @velocity =0
    if @@types.key?(type)
      @type = @@types[type]
    elsif @@types.value?(type)
      @type = type
    else
      puts "Unknown type. We used def type 'Пассажирский'"
      @type = "пассажирский"
    end
  end

  def accelerate
    @velocity+=1
  end
  def stop
    @velocity = 0
  end
  def new_count
    @velocity == 0? @count+=1 :  puts("Please!!! Stop the train!!!")
  end
  def del_count
    @velocity == 0? @count-=1 :  puts("Please!!! Stop the train!!!")
  end
  def take_route(route)
    @route = route
    @route.stations.first.train_arrival(self)
    @current_station = 1
  end
  def next_station
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

  def prev_station
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
end