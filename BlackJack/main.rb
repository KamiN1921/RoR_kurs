#класс интерфейс, отвечающий за логику самой игры
class Interface
  #игроки(пользователь + диллер) есть возможность позже добавить несколько игроков
  @players = [] << Player.new("Diler",1)
  #колода
  @deck = Deck.new
  @bank = 0
  # 1 - exit
  # 2- open_cards
  # 3 - skip
  # 4 - new card
  @player_decision = "new"
  @winner

  def retry_game?
    puts "Хотите сыграть еще раз? (Для выхода введите 1 или no)"
    @players_decision = gets.chomp
   (@players_decision =="no"|| @players_decision  =="1") ? false : true
  end

  #старт игры (создание игрока, запуск игры)
  def initialize
    loop do
      new_game
      break unless retry_game?
    end
  end

  def get_player_name
    puts "Введите имя игрока"
    gets.chomp
  end

  # подсчет очков
  # новая игра(сбор банка)
  def new_game
    @players << Player.new(get_player_name,2)
    get_start_hand
    show_cards # показать пользователю карты, и звездочки вместо карт диллера
    count_points
    bet #сделать стандартную ставку
    loop do
      make_move
      show_cards
      coun_points
      break if have_three_card? || (@players_decision = 2)
    end
    who_win?
    end

  def get_start_hand
    @players.each do |player|
      player.get_card(@deck)
      player.get_card(@deck)
    end
  end
  # ход(сделать ход)
  # запрос действия
  # вскрыть карты(если пользователь вскрывается, либо у одного из игроков 3 карты)
  # определение победителя

end

