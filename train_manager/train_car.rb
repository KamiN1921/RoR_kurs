class TrainCar
  include InstanceCounter
  include Manufacturer

  attr_reader :number
  attr_reader :taken_space
  attr_reader :space

  def type
    self.TYPE
  end


  def free_space
    @space - @taken_space
  end

  protected

  def initialize(x)
    register_instance
  end

end