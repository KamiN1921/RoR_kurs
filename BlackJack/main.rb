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
  # all - new game
  @player_decision = 5
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
  def count_points
    # code here
  end

  def bet
    # code here
  end

  def have_three_card?
    # code here
  end

  def who_win?
    # code here
  end

  def open_all
    # code here
  end

  def new_game
    @players << Player.new(get_player_name,2)
    get_start_hand
    bet #сделать стандартную ставку

    loop do
      show_cards
      count_points
      make_move
      break if have_three_card? || (@players_decision = 2)
    end

    open_all
    who_win?
    end

  def get_start_hand
    @players.each do |player|
      player.get_card(@deck)
      player.get_card(@deck)
    end
  end
  # ход(сделать ход)
  def make_move

  end
  # запрос действия
  def get_user_action

  end
  # вскрыть карты(если пользователь вскрывается, либо у одного из игроков 3 карты)
  def show_cards

  end
  # определение победителя

end

