class Route
  attr_reader :stations
  def initialize(first_station,last_station)
    @stations=[]
    @stations<<first_station<<last_station
  end
  def first_station
    @stations.first
  end
  def last_station
    @stations.last
  end
  def add_station(station,pos=-2)
    if pos == 0
      pos = 1
    elsif pos == -1 || pos >= @stations.length - 1
      pos = -2
    end
    if @stations.find_all { |element| element.name == station.name }.empty?
      @stations.insert(pos.to_i, station)
    else
      puts "This station already in this route"
    end
  end
  def del_station(name)
    if @stations.first.name == name || @stations.last.name == name
      puts "We can't delete first or last station from route"
    else
    @stations.delete_if{|point| point.name == name}
    end
  end
  def print_route
    @stations.each {| point | puts "Station: #{point.name}"}
    @stations
  end
end