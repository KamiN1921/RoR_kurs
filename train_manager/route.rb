class Route
  attr_reader :stations
  include InstanceCounter

  def valid?
   @stations.first.name!=@stations.last.name && @stations.length==2
  end

  def initialize(first_station,last_station)
    @stations=[]
    @stations<<first_station<<last_station
    raise "Для создания маршрута нужны две различные станции" if !valid?
  end

  def first_station
    @stations.first
  end

  def last_station
    @stations.last
  end

  def add_station(station,pos=-2)
    @stations.insert(pos.to_i, station)
  end

  def del_station(name)
    @stations.delete_if{|point| point.name == name}
  end

  def print_route
    @stations.each {| point | puts "Station: #{point.name}"}
    @stations
  end
end