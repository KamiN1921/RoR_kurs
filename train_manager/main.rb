$LOAD_PATH.push('/Users/dchaenkova/RubymineProjects/RoR_kurs/train_manager/')
require 'instance_counter'
require 'manufacturer'
require 'station'
require 'route'
require 'train'
require 'train_car'
require 'cargo_train'
require 'passenger_train'
require 'passenger_train_car'
require 'cargo_train_car'


class Interface
  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def print_stations
    puts "Станции"
    @stations.each { |x| puts x.name}
  end

  def print_trains
    puts "Поезда"
    @trains.each { |x| puts x.number}
  end

  def print_routes
    puts "Маршруты"
    @routes.each {|x| puts "#{x.first_station.name} - #{x.last_station.name}"}
  end

  def bad_number?(x,mass)
    if x>mass.length || x<1
      puts "Некорректное значение"
      true
    else false
    end
  end

  def demonstration
    puts"Введите название компании производителя для поезда"
    company = gets.chomp.to_str
    puts "Введите номер поезда, которому хотите добавить производителя"
    number = gets.chomp
    train = Train.find(number)
    unless train.nil?
      train.company = company
      puts "Поезду номер #{train.number} установлен производитель #{train.company}"
    end

    puts "Количество созданных грузовых поездов - #{CargoTrain.instances}"
  end

  def print_station_trains(station,type)
    case type
      when "cargo"
        puts "Грузовые поезда станции #{@stations[station-1].name}"
        @stations[station - 1].get_trains_by_type("cargo").each do |train|
          puts "#{train.TYPE} поезд номер #{ train.number }"
        end
      when "passenger"
        puts "Пассажирские поезда станции #{@stations[station-1].name}"
        @stations[station - 1].get_trains_by_type("passenger").each do |train|
          puts "#{train.TYPE} поезд номер #{ train.number }"
        end
      else
        puts "Все поезда станции #{@stations[station-1].name}"
        @stations[station - 1].trains.each do |train|
          puts "#{train.TYPE} поезд номер #{ train.number }"
        end
    end
  end

  def new_station
    begin
    puts "Введите название станции"
    name = gets.chomp
    @stations.push(Station.new("#{name}"))
    rescue StandardError => e
      puts e.message
      retry
    end
    puts "Создана станция #{name}"
  end

  def is_here?(train,station)
    puts "This station already has this train" unless station.trains.find(train.number)
  end

  def new_train
    begin
    puts "Введите номер поезда (в формате ХХХ-ХХ или ХХХХХ, где Х - буква или цифра)"
    name = gets.chomp.to_str
    puts "Укажите необходимый тип поезда ('грузовой' или 'пассажирский')"
    type = gets.chomp
    puts "Укажите количество вагонов"
    count = gets.chomp.to_i
    if type == "грузовой"
      @trains.push(CargoTrain.new(name,count))
    elsif type == "пассажирский"
      @trains.push(PassengerTrain.new(name,count))
    else raise "Неверный тип поезда/данных"
    end
    rescue RuntimeError => e
      puts e.message
      retry
    rescue NoMethodError
      puts "Неизвестная ошибка, объект не создан"
      retry
    end
    puts "Создан #{@trains.last.TYPE} поезд номер #{@trains.last.number} #{@trains.last.count_of_cars} вагонов"
  end

  def new_route
    begin
      print_stations
      puts "Введите порядковый номер 1ой станции маршрута"
      first = gets.chomp.to_i
      puts "Введите порядковый номер 2ой станции маршрута"
      second = gets.chomp.to_i
    raise "Неверный порядковый номер станции" if bad_number?(first, @stations) || bad_number?(second, @stations)
      rescue StandardError => e
    raise e.message
    end
    @routes.push(Route.new(@stations[first-1],@stations[second-1]))
    puts "Создан маршрут  #{@routes.last.first_station.name} - #{@routes.last.last_station.name}"
  end

  def delete_station_from_route(route)
    puts "Введите название станции"
    print_stations
    name = gets.chomp
    raise "We can't delete first or last station from route" if @routes[route-1].first_station.name == name||@routes[route-1].last_station.name == name
    @routes[route-1].del_station(name)
  end

  def add_station_in_route(route)
    puts "Введите номер станции"
    print_stations
    station = gets.chomp.to_i
    raise "Введите порядковый номер новой станции в маршруте" unless bad_number?(station,@stations)&&@routes[route-1].stations.find_all{|x| x.name == @stations[station-1].name}.empty?
      pos = gets.chomp.to_i
      if pos == 0
        @routes[route-1].add_station(@stations[station - 1])
      elsif pos == -1 || pos >= @routes[route-1].stations.length - 1
        pos = -2
      end
      @routes[route-1].add_station(@stations[station - 1],pos - 1)
  end

  def edit_route
    raise "Нет маршрутов для редактирования. Создайте хотя бы один маршрут" if @routes.empty?
      print_routes
      puts "Введите порядковый номер маршрута"
      route = gets.chomp.to_i
    raise "Маршрут с таким номером отсутствует" if bad_number?(route,@routes)
    puts "Если вы хотите удалить станцию из маршрута введите 1 и 2 если добавить"
    action = gets.chomp.to_i
    if action == 1
      begin
      delete_station_from_route(route)
      rescue StandardError =>e
        puts e.message
      end
      puts "Станция удалена из маршрута"
    elsif action == 2
      begin
      add_station_in_route(route)
      rescue StandardError =>e
        puts e.message
      end
      puts "Станция добавлена в маршрут"
    end
  end

  def route_manage
    puts "Введите 1 для создания маршрута"
    puts "Введите 2 для редактирования маршрута"
    puts "Введите что-то еще для возвращения в главное меню"
    chose = gets.chomp
    case chose
    when "1"
      begin
        new_route
      rescue StandardError => e
        puts e.message
      end
    when "2"
      begin
      edit_route
      rescue StandardError => e
      puts e.message
    end
    else puts "Вы возвращены в главное меню"
    end
  end

  def give_route
    puts "Введите порядковый номер поезда в списке"
    print_trains
    train = gets.chomp.to_i
    puts "Введите порядковый номер маршрута в списке"
    print_routes
    route = gets.chomp.to_i
    raise "Неверно задана пара поезд - маршрут. Попробуйте еще раз." if (bad_number?(train,@trains)||bad_number?(route,@routes))
      @trains[train-1].take_route(@routes[route-1])
  end

  def add_cars_to_train
    raise "Создайте хоть один поезд" if @trains.empty?
    puts "Введите порядковый номер поезда"
    print_trains
    train = gets.chomp.to_i
    raise "Выход за границы массива" if bad_number?(train,@trains)
    @trains[train-1].add_train_car
  end

  def pop_cars_from_train
    raise "Создайте хоть один поезд"if @trains.empty?
    puts "Введите порядковый номер поезда"
    print_trains
    train = gets.chomp.to_i
    @trains[train-1].pop_train_car unless bad_number?(train,@trains)
  end

  def next_st(train)
    raise "Не назначен маршрут, мой капитан!" if train.route.nil?
    raise "Это конечная, назначьте новый маршрут" if train.route.stations.length <= train.current_station_index+1
      train.next_station
    puts "Поезд прибыл на следующую станцию"
  end

  def list_trains
    raise "Создайте хоть один поезд и хоть одну станцию" if @trains.empty?|| @stations.empty?
      puts "Выберите станцию для просмотра всех поездов на ней"
      print_stations
      station = gets.chomp.to_i
    raise "Неверный номер станции" if bad_number?(station,@stations)
    puts "Введите all для вывода всех поездов станции"
    puts "Введите cargo для вывода грузовых поездов станции"
    puts "Введите passenger для вывода пассажирских поездов станции"
    chose = gets.chomp.to_str
    print_station_trains(station,chose)
  end

  def prev_st(train)
    raise "Не назначен маршрут, мой капитан!" if train.route.nil?
    raise "Ни шагу назад, это первая станция маршрута!" if train.current_station_index == 0
      train.prev_station
    puts "Поезд вернулся на одну станциюы"
  end

  def start_moving
    loop do
      raise "Создайте хоть один поезд и один маршрут" if @trains.empty?||@routes.empty?
      puts "Введите порядковый номер поезда"
      print_trains
      train = gets.chomp.to_i
      raise "Неверный порядковый номер поезда" if bad_number?(train,@trains)
      puts "Выберете направление (положительное число - одна станция вперед, 0 - прекратить движение и вернуться в меню, и отрицательное - станция назад)"
      direction = gets.chomp.to_i
      begin
      if direction > 0
        next_st(@trains[train-1])
      elsif direction<0
        prev_st(@trains[train-1])
      else break
      end
      rescue StandardError => e
        raise "#{e.message}"
      end
    end
  end

  def hello_message
    puts " - Для создания станции введите 1"
    puts " - Для создания поезда введите 2"
    puts " - Для работы с маршрутом(создание/редактирование) введите 3"
    puts " - Для назначения маршрута поеду введите 4"
    puts " - Для добавления вагона к поезду введите 5"
    puts " - Для отцепления вагона от поезда введите 6"
    puts " - Для начала перемещения по маршруту нажмите 7"
    puts " - Для начала просмотра списка поездов на станции нажмите 8"
    puts " - Для демонстрации работы модулей введите 9"
    puts " - Exit 10"
  end

  def menu
    loop do
      hello_message
      @command = gets.chomp
      case @command
      when "1"
        new_station
      when "2"
        new_train
      when "3"
        route_manage
      when "4"
        begin
        raise "Невозможно назначить маршрут поезду. создайте хотябы один поезд и один маршрут" if @routes.empty? || @trains.empty?
        give_route
        rescue StandardError => e
          puts e.message
        else
        puts "Маршрут назначен"
        end
      when "5"
        begin
        add_cars_to_train
        rescue StandardError => e
          puts e.message
        else
        puts "Вагон добавлен"
        end
      when "6"
        begin
        pop_cars_from_train
        rescue StandardError => e
          puts e.message
        else
        puts "Вагон отцеплен"
        end
      when "7"
        begin
        start_moving
        rescue StandardError => e
          puts e.message
        end
      when "8"
        begin
        list_trains
        rescue StandardError => e
          puts e.message
        end
      when "9"
        demonstration
      when "10"
        break
      else puts "Неверная комманда"
      end
    end
  end
end

puts "Приветствуем Вас в менеджере железной дороги"
program = Interface.new
program.menu

