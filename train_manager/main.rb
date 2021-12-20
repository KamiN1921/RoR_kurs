# frozen_string_literal: true

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
    puts 'Станции'
    @stations.each { |x| puts x.name }
  end

  def print_trains
    puts 'Поезда'
    @trains.each { |x| puts x.number }
  end

  def print_routes
    puts 'Маршруты'
    @routes.each { |x| puts "#{x.first_station.name} - #{x.last_station.name}" }
  end

  def bad_number?(number, mass)
    if number > mass.length || number < 1
      puts 'Некорректное значение'
      true
    else
      false
    end
  end

  # def demonstration
  # puts"Введите название компании производителя для поезда"
  #  company = gets.chomp.to_str
  #  puts "Введите номер поезда, которому хотите добавить производителя"
  #  number = gets.chomp
  #  train = Train.find(number)
  # unless train.nil?
  #    train.company = company
  #    puts "Поезду номер #{train.number} установлен производитель #{train.company}"

  #   train.each_train_car{|x| puts x.free_space unless x.nil?}
  #  end

  # puts "Количество созданных грузовых поездов - #{CargoTrain.instances}"

  # @stations[0].each_train{|x| puts x.number unless x.nil?} unless @stations.empty?
  # end

  def print_cars(train)
    raise 'Неверный тип' unless train.type == 'грузовой' || train.type == 'пассажирский'

    train.each_train_car do |car|
      puts "Вагон #{car.type} номер #{car.number} свободного места #{car.free_space} из #{car.space}"
    end
  end

  def print_train_cars(train)
    puts "#{train.type} поезд номер #{train.number} количество вагонов #{train.count_of_cars}"
    puts 'Вагоны данного поезда'
    print_cars(train)
  end

  def print_station_trains(station, type)
    if %w[cargo passenger].include?(type)
      puts "Поезда станции #{@stations[station - 1].name}"
      @stations[station - 1].get_trains_by_type(type).each { |train| print_train_cars(train) }
    else
      puts "Все поезда станции #{@stations[station - 1].name}"
      @stations[station - 1].each_train { |train| print_train_cars(train) }
    end
  end

  def new_station
    begin
      puts 'Введите название станции'
      name = gets.chomp
      @stations.push(Station.new(name.to_s))
    rescue StandardError => e
      puts e.message
      retry
    end
    puts "Создана станция #{name}"
  end

  def here?(train, station)
    puts 'This station already has this train' unless station.trains.find(train.number)
  end

  def new_train
    begin
      puts 'Введите номер поезда (в формате ХХХ-ХХ или ХХХХХ, где Х - буква или цифра)'
      name = gets.chomp.to_str
      puts "Укажите необходимый тип поезда ('грузовой' или 'пассажирский')"
      type = gets.chomp
      puts 'Укажите количество вагонов'
      count = gets.chomp.to_i
      case type
      when 'грузовой'
        block = proc do
          puts 'Введите количество места в вагоне'
          count_of_space = gets.chomp.to_i
          count_of_space
        end

        @trains.push(CargoTrain.new(name, count, &block))
      when 'пассажирский'
        block = proc do
          puts 'Введите количество сидячих мест в вагоне'
          count_of_seats = gets.chomp.to_i
          count_of_seats
        end

        @trains.push(PassengerTrain.new(name, count, &block))
      else
        raise 'Неверный тип поезда/данных'
      end
    rescue RuntimeError => e
      puts e.message
      retry
    rescue NoMethodError
      puts 'Неизвестная ошибка, объект не создан'
      retry
    end
    puts "Создан #{@trains.last.type} поезд номер #{@trains.last.number} #{@trains.last.count_of_cars} вагонов"
  end

  def new_route
    begin
      print_stations
      puts 'Введите порядковый номер 1ой станции маршрута'
      first = gets.chomp.to_i
      puts 'Введите порядковый номер 2ой станции маршрута'
      second = gets.chomp.to_i
      raise 'Неверный порядковый номер станции' if bad_number?(first, @stations) || bad_number?(second, @stations)
    rescue StandardError => e
      raise e.message
    end
    @routes.push(Route.new(@stations[first - 1], @stations[second - 1]))
    puts "Создан маршрут  #{@routes.last.first_station.name} - #{@routes.last.last_station.name}"
  end

  def delete_station_from_route(route)
    puts 'Введите название станции'
    print_stations
    name = gets.chomp
    if @routes[route - 1].first_station.name == name || @routes[route - 1].last_station.name == name
      raise "We can't delete first or last station from route"
    end

    @routes[route - 1].del_station(name)
  end

  def add_station_in_route(route)
    puts 'Введите номер станции'
    print_stations
    station = gets.chomp.to_i
    raise 'Введите порядковый номер новой станции в маршруте' unless bad_number?(station,
                                                                                 @stations) && @routes[route - 1].stations.find_all do |x|
                                                                                                 x.name == @stations[station - 1].name
                                                                                               end.empty?

    pos = gets.chomp.to_i
    if pos.zero?
      @routes[route - 1].add_station(@stations[station - 1])
    elsif pos == -1 || pos >= @routes[route - 1].stations.length - 1
      pos = -2
    end
    @routes[route - 1].add_station(@stations[station - 1], pos - 1)
  end

  def edit_route
    raise 'Нет маршрутов для редактирования. Создайте хотя бы один маршрут' if @routes.empty?

    print_routes
    puts 'Введите порядковый номер маршрута'
    route = gets.chomp.to_i
    raise 'Маршрут с таким номером отсутствует' if bad_number?(route, @routes)

    puts 'Если вы хотите удалить станцию из маршрута введите 1 и 2 если добавить'
    action = gets.chomp.to_i
    case action
    when 1
      begin
        delete_station_from_route(route)
      rescue StandardError => e
        puts e.message
      end
      puts 'Станция удалена из маршрута'
    when 2
      begin
        add_station_in_route(route)
      rescue StandardError => e
        puts e.message
      end
      puts 'Станция добавлена в маршрут'
    end
  end

  def route_manage
    puts 'Введите 1 для создания маршрута'
    puts 'Введите 2 для редактирования маршрута'
    puts 'Введите что-то еще для возвращения в главное меню'
    chose = gets.chomp
    case chose
    when '1'
      begin
        new_route
      rescue StandardError => e
        puts e.message
      end
    when '2'
      begin
        edit_route
      rescue StandardError => e
        puts e.message
      end
    else puts 'Вы возвращены в главное меню'
    end
  end

  def give_route
    puts 'Введите порядковый номер поезда в списке'
    print_trains
    train = gets.chomp.to_i
    puts 'Введите порядковый номер маршрута в списке'
    print_routes
    route = gets.chomp.to_i
    raise 'Неверно задана пара поезд - маршрут. Попробуйте еще раз.' if bad_number?(train,
                                                                                    @trains) || bad_number?(route,
                                                                                                            @routes)

    @trains[train - 1].take_route(@routes[route - 1])
  end

  def add_cars_to_train
    raise 'Создайте хоть один поезд' if @trains.empty?

    puts 'Введите порядковый номер поезда'
    print_trains
    train = gets.chomp.to_i
    raise 'Выход за границы массива' if bad_number?(train, @trains)

    @trains[train - 1].add_train_car
  end

  def pop_cars_from_train
    raise 'Создайте хоть один поезд' if @trains.empty?

    puts 'Введите порядковый номер поезда'
    print_trains
    train = gets.chomp.to_i
    @trains[train - 1].pop_train_car unless bad_number?(train, @trains)
  end

  def next_st(train)
    raise 'Не назначен маршрут, мой капитан!' if train.route.nil?
    raise 'Это конечная, назначьте новый маршрут' if train.route.stations.length <= train.current_station_index + 1

    train.next_station
    puts 'Поезд прибыл на следующую станцию'
  end

  def list_trains
    raise 'Создайте хоть один поезд и хоть одну станцию' if @trains.empty? || @stations.empty?

    puts 'Выберите станцию для просмотра всех поездов на ней'
    print_stations
    station = gets.chomp.to_i
    raise 'Неверный номер станции' if bad_number?(station, @stations)

    puts 'Введите all для вывода всех поездов станции'
    puts 'Введите cargo для вывода грузовых поездов станции'
    puts 'Введите passenger для вывода пассажирских поездов станции'
    chose = gets.chomp.to_str
    print_station_trains(station, chose)
  end

  def prev_st(train)
    raise 'Не назначен маршрут, мой капитан!' if train.route.nil?
    raise 'Ни шагу назад, это первая станция маршрута!' if train.current_station_index.zero?

    train.prev_station
    puts 'Поезд вернулся на одну станциюы'
  end

  def start_moving
    loop do
      raise 'Создайте хоть один поезд и один маршрут' if @trains.empty? || @routes.empty?

      puts 'Введите порядковый номер поезда'
      print_trains
      train = gets.chomp.to_i
      raise 'Неверный порядковый номер поезда' if bad_number?(train, @trains)

      puts 'Выберете направление (положительное число - одна станция вперед, 0 - прекратить движение и вернуться в меню'
      puts ' и отрицательное - станция назад)'
      direction = gets.chomp.to_i
      begin
        if direction.positive?
          next_st(@trains[train - 1])
        elsif direction.negative?
          prev_st(@trains[train - 1])
        else
          break
        end
      rescue StandardError => e
        raise e.message.to_s
      end
    end
  end

  def hello_message
    puts ' - Для создания станции введите 1'
    puts ' - Для создания поезда введите 2'
    puts ' - Для работы с маршрутом(создание/редактирование) введите 3'
    puts ' - Для назначения маршрута поеду введите 4'
    puts ' - Для добавления вагона к поезду введите 5'
    puts ' - Для отцепления вагона от поезда введите 6'
    puts ' - Для начала перемещения по маршруту нажмите 7'
    puts ' - Для начала просмотра списка поездов на станции нажмите 8'
    puts ' - Занять место в поезде 9'
    puts ' - Посмотреть список вагонов поезда 10'
    puts ' - Exit 11'
  end

  def list_cars
    print_trains
    puts 'Введите номер поезда, вагоны которого хотите посмотреть'
    number = gets.chomp.to_str
    train = Train.find(number)
    raise 'Поезд отсутствует' if train.nil?

    print_cars(train)
  end

  def take_place
    print_trains
    puts 'Введите номер поезда, в котором хотите занять место'
    number = gets.chomp.to_str
    train = Train.find(number)
    raise 'Поезд отсутствует' if train.nil?

    puts 'Введите номер вагона, в котором хотите занять место'
    train_car = gets.chomp.to_i
    unless train.count_of_cars >= train_car && train.count_of_cars.positive? && train_car.positive?
      raise 'В этом поезде нет такого вагона'
    end

    if train.is_a? PassengerTrain
      train.each_train_car { |car| car.take_seat if car.number == train_car }
    else
      begin
        puts 'Введите объем груза'
        v = gets.chomp.to_i
        raise 'Груз должен занимать какой-то положительный объем' unless v.positive?

        train.each_train_car { |car| car.take_space(v) if car.number == train_car }
      rescue StandardError => e
        puts e.message
        retry
      end
    end
    puts 'Место занято'
  end

  def menu
    loop do
      hello_message
      @command = gets.chomp
      case @command
      when '1'
        new_station
      when '2'
        new_train
      when '3'
        route_manage
      when '4'
        begin
          if @routes.empty? || @trains.empty?
            raise 'Невозможно назначить маршрут поезду. создайте хотябы один поезд и один маршрут'
          end

          give_route
        rescue StandardError => e
          puts e.message
        else
          puts 'Маршрут назначен'
        end
      when '5'
        begin
          add_cars_to_train
        rescue StandardError => e
          puts e.message
        else
          puts 'Вагон добавлен'
        end
      when '6'
        begin
          pop_cars_from_train
        rescue StandardError => e
          puts e.message
        else
          puts 'Вагон отцеплен'
        end
      when '7'
        begin
          start_moving
        rescue StandardError => e
          puts e.message
        end
      when '8'
        begin
          list_trains
        rescue StandardError => e
          puts e.message
        end
      when '9'
        begin
          take_place
        rescue StandardError => e
          puts e.message
        end
      when '10'
        begin
          list_cars
        rescue StandardError => e
          puts e.message
        end
      when '11'
        break
      else puts 'Неверная комманда'
      end
    end
  end
end

puts 'Приветствуем Вас в менеджере железной дороги'
program = Interface.new
program.menu
