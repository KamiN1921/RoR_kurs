#класс интерфейс, отвечающий за логику самой игры
class Interface
  #игроки(пользователь + диллер) есть возможность позже добавить несколько игроков
  @players = [] << Dealer.new
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
  def count_points
    count = 0
    @players.each{ |player| count += player.count}
    count
  end

  def bet(bet)
    @players.each{ |player| @bank +=player.bet(bet)}
  end

  def have_three_card?
    flag = true
    @players.each {|player| flag = flag && player.have_three_cards? }
    flag
  end

  # определение победителя
  def who_win?
    # code here
  end

  def open_all
    @players.each {|player| player.open_hand}
  end

  # новая игра(сбор банка)
  def new_game
    @players << Player.new(get_player_name)
    get_start_hand
    bet(20) #сделать стандартную ставку

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
      player.get_card(@deck.get_card)
      player.get_card(@deck.get_card)
    end
  end
  def menu
    puts "Для выхода нажмите 1"
    puts "Для вскрытия карт нажмите 2"
    puts "Для пропуска хода нажмите 3"
    puts "Для набора карт нажмите 4"
  end

  # ход(сделать ход)

  def move(move,player)
    case move
    when "2"
      open_all
    when "3"

    when "4"
      if !player.have_three_cards?
      player.get_card(@deck.get_card)
      else raise "Слишком много карт"
      end
    else
      raise "Неправильно выбрано действие"
    end

  end

  def make_move
    begin
      menu
      @players.each do |player|
        if player.class != Dealer
        move = get_user_action
        move(move,player)
        else
          player.dealers_decision(@deck.get_card)
        end

      end
    rescue RuntimeError=>e
      puts e.message
      retry
    end
  end

  # запрос действия
  def get_user_action
    puts "Выберите действие"
    gets.chomp
  end

  # отрисовать карты
  def show_cards
    @players.each {|player| player.show_hand}
  end
end

