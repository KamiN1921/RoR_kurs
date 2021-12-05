$LOAD_PATH.push('/Users/dchaenkova/RubymineProjects/RoR_kurs/lesson3/')

require 'station'
require 'route'
require 'train'
require 'train_car'
require 'cargo_train'
require 'passenger_train'
require 'passenger_train_car'
require 'cargo_train_car'

$stations = []
$routes = []
$trains = []

def print_stations
  puts "Станции"
  $stations.each { |x| puts x.name}
end
def print_trains
  puts "Поезда"
  $trains.each { |x| puts x.number}
end
def print_routes
  puts "Маршруты"
  $routes.each {|x| puts "#{x.first_station.name} - #{x.last_station.name}"}
end
def bad_number?(x,mass)
  if x>mass.length || x<1
    puts "Некорректное значение"
    true
  else false
  end
end

def print_station_trains(station,type="all")
  case type
  when "all"
    puts "поезда станции #{$stations[station-1].name}"
    $stations[station - 1].trains.each{|train| puts "#{train.TYPE} поезд номер #{ train.number }"}
  when "cargo"
    puts "Грузовые поезда станции #{$stations[station-1].name}"
    $stations[station - 1].get_trains_by_type("cargo").each{|train| puts "#{train.TYPE} поезд номер #{ train.number }"}
  when "passenger"
    puts "Пассажирские поезда станции #{$stations[station-1].name}"
    $stations[station - 1].get_trains_by_type("passenger").each{|train| puts "#{train.TYPE} поезд номер #{ train.number }"}
  else puts "Error"
  end

end

puts "Приветствуем Вас в менеджере железной дороги"

loop do
  puts " - Для создания станции введите 1"
  puts " - Для создания поезда введите 2"
  puts " - Для работы с маршрутом(создание/редактирование) введите 3"
  puts " - Для назначения маршрута поеду введите 4"
  puts " - Для добавления вагона к поезду введите 5"
  puts " - Для отцепления вагона от поезда введите 6"
  puts " - Для начала перемещения по маршруту нажмите 7"
  puts " - Для начала просмотра списка поездов на станции нажмите 8"
  puts " - Exit 9"
  command = gets.chomp
  case command
  when "1"
    puts "Введите название станции"
    name = gets.chomp
    $stations.push(Station.new("#{name}"))
  when "2"
    puts "Введите номер поезда"
    name = gets.chomp
    puts "Укажите необходимый тип поезда ('грузовой' или 'пассажирский')"
    type = gets.chomp
    if type == "грузовой"
      $trains.push(CargoTrain.new("#{name}"))
    elsif type == "пассажирский"
      $trains.push(PassengerTrain.new("#{name}"))
    else
      puts "Неверный тип. Вы будете перемещеы в меню"
    end
  when "3"
    puts "Введите 1 для создания маршрута"
    puts "Введите 2 для редактирования маршрута"
    puts "Введите что-то еще для возвращения в главное меню"
    chose = gets.chomp
    case chose
    when "1"
      if $stations.length >=2
        print_stations
      puts "Введите порядковый номер 1ой станции маршрута"
      first = gets.chomp.to_i
      break if bad_number?(first,$stations)
      puts "Введите порядковый номер 2ой станции маршрута"
      second = gets.chomp.to_i
      break if bad_number?(second,$stations)
        $routes.push(Route.new($stations[first-1],$stations[second-1]))
      else
        puts "Недостаточно станций для составления маршрута. Вернитесь в меню и создайте минимум 2 станции"
      end
    when "2"
      if $routes.empty?
        puts "Нет маршрутов для редактирования. Создайте хотя бы один маршрут"
      else
        print_routes
        puts "Введите порядковый номер маршрута"
        route = gets.chomp.to_i
        break if bad_number?(route,$routes)
        puts "Если вы хотите удалить станцию из маршрута введите 1 и 2 если добавить"
        action = gets.chomp.to_i
        if action == 1
          puts "Введите название станции"
          print_stations
          name = gets.chomp
          $routes[route-1].del_station(name)
        elsif action == 2
        puts "Введите номер станции"
        print_stations
        station = gets.chomp.to_i
        unless bad_number?(station,$stations)
        puts "Введите порядковый номер новой станции в маршруте"
        pos = gets.chomp.to_i
        $routes[route-1].add_station($stations[station - 1],pos - 1)
        end
        end
      end
      else puts "Вы возвращены в главное меню"
    end
  when "4"
    if $routes.empty? || $trains.empty?
      puts "Невозможно назначить маршрут поезду. создайте хотябы один поезд и один маршрут"
    else
    puts "Введите порядковый номер поезда в списке"
    print_trains
    train = gets.chomp.to_i
    break if bad_number?(train,$trains)
    puts "Введите порядковый номер маршрута в списке"
    print_routes
    route = gets.chomp.to_i
    break if bad_number?(route,$routes)
    $trains[train-1].take_route($routes[route-1])
    end
  when "5"
    if $trains.empty?
      puts "Создайте хоть один поезд"
    else
    puts "Введите порядковый номер поезда"
    print_trains
    train = gets.chomp.to_i
    break if bad_number?(train,$trains)
    if $trains[train-1].is_a? CargoTrain
      $trains[train-1].add_train_car(CargoTrainCar.new)
    else
      $trains[train-1].add_train_car(PassengerTrainCar.new)
    end
    end
  when "6"
    if $trains.empty?
      puts "Создайте хоть один поезд"
    else
    puts "Введите порядковый номер поезда"
    print_trains
    train = gets.chomp.to_i
    break if bad_number?(train,$trains)
    $trains[train-1].pop_train_car
    end
  when "7"
    if $trains.empty?||$routes.empty?
      puts "Создайте хоть один поезд и один маршрут"
    else
    puts "Введите порядковый номер поезда"
    print_trains
    train = gets.chomp.to_i
    break if bad_number?(train,$trains)
    puts "Выберете направление (положительное число - одна станция вперед, 0 и отрицательное - станция назад)"
    direction = gets.chomp.to_i
    if direction > 0
      $trains[train-1].next_station
    else
      $trains[train - 1].prev_station
    end
    end
  when "8"
    if $trains.empty?|| $stations.empty?
      puts "Создайте хоть один поезд и хоть одну станцию"
    else
    puts "Выберите станцию для просмотра всех поездов на ней"
    print_stations
    station = gets.chomp.to_i
    break if bad_number?(station,$stations)
    puts "Введите all для вывода всех поездов станции"
    puts "Введите cargo для вывода грузовых поездов станции"
    puts "Введите passenger для вывода пассажирских поездов станции"
    chose = gets.chomp.to_str
    print_station_trains(station,chose)
    end
  when "9"
    break
  else puts "Неверная комманда"
  end
end



