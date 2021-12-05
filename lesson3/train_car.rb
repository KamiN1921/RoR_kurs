class TrainCar
  private
  @@counter = 0
  protected
  attr_reader :number

  def initialize
    @number = @@counter
    @@counter+=1
  end

end