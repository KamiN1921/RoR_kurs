# frozen_string_literal: true

class TrainCar
  include InstanceCounter
  include Manufacturer
  include Validation

  attr_reader :number, :taken_space, :space
  def type
    self.TYPE
  end

  def free_space
    @space - @taken_space
  end

  protected

  def initialize(space)
    register_instance
    @space = space
    @taken_space = 0
    validate!
  end
end
