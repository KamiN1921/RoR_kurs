$LOAD_PATH.push('/Users/dchaenkova/RubymineProjects/RoR_kurs/lesson3/')

require 'station'
require 'route'
require 'train'

first =Station.new("First")
second =Station.new("Second")
third =Station.new("Third")
fourth =Station.new("Fourth")
fifth =Station.new("Fifth")

firstroute = Route.new(first,fifth)
train1 = Train.new("number","1", "2")
train1.new_count
puts train1.count
train1.accelerate
puts train1.velocity
train1.accelerate
puts train1.velocity
train1.del_count
train1.stop
puts train1.velocity
train1.del_count
puts train1.del_count
train1.prev_station
train1.take_route(firstroute)
train1.prev_station
train1.next_station
train1.next_station
train1.prev_station

secondroute = Route.new(first,third)
secondroute.add_station(fifth)
secondroute.del_station("First")
secondroute.add_station(second,2)
secondroute.add_station(fourth,3)
secondroute.print_route
train2 = Train.new("Train2", "2", 5)
train2.take_route(secondroute)
train2.next_station
train2.prev_station
first.get_trains_by_type("пассажирский").each{|x|puts "#{x.number} : #{x.type}"}
first.trains.each { |x| puts "#{x.number} :::#{x.type}"}




