# frozen_string_literal: true

class Station
  attr_reader :name, :trains

  include Validation
  include InstanceCounter
  @@all_stations = []

  def validateobj
    self.class.validate @name, 'presence'
    self.class.validate @name, 'format', /\A&\d|[a-z]|[а-я]/
    self.validate!
  end

  def each_train(&block)
    @trains.each { |train| block.call(train) }
  end

  def initialize(name)
    @trains = []
    @name = name
    validateobj
    @@all_stations << self
  end

  def train_arrival(train)
    @trains << train
  end

  def get_trains_by_type(type)
    case type
    when 'passenger'
      @trains.find_all { |train| train.is_a? PassengerTrain }
    when 'cargo'
      @trains.find_all { |train| train.is_a? CargoTrain }
    end
  end

  def train_departure(number)
    @trains.delete_if { |train| train.number == number }
  end

  def self.all
    @@all_stations
  end
end
