class Player
  @bank = 100
  #рука(массив карт на руке)(3)
  @hand =[]
  # имя
  @name

  @points
  # тип(авто 1 либо игрок 2)
  @type
  # создать игрока(имя и тип)
  def initialize(name, type)
    @type = type
    # валидация имени
    if type == 1
       Diler.new(name)
    else
      @name = name
    end

  end
  # взять карту
  # пропустить
  # открыть карты
  # ставка
end
