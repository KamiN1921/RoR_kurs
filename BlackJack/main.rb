# frozen_string_literal: true
#
$LOAD_PATH.push('/Users/dchaenkova/RubymineProjects/RoR_kurs/BlackJack/')
require "deck.rb"
require "player.rb"
require "dealer.rb"

# класс интерфейс, отвечающий за логику самой игры
class Interface

  def retry_game?
    puts 'Хотите сыграть еще раз? (Для выхода введите 1 или no)'
    @players_decision = gets.chomp
    @players_decision == 'no' || @players_decision == '1' ? false : true
  end

  # старт игры (создание игрока, запуск игры)
  def initialize
    # игроки(пользователь + диллер) есть возможность позже добавить несколько игроков
    # колода
    # 1 - exit
    # 2- open_cards
    # 3 - skip
    # 4 - new card
    # all - new game
    @can_pass_move = true
    @player_decision = 5
    @bank = 0
    @players = []
    @deck = Deck.new
    loop do
      new_game
      break unless retry_game?
      break unless no_money?
    end
  end

  def no_money?
    @players.each do |player|
      puts"#{player.name} имеет #{player.bank}"
      return true if (player.bank <= 0)
    end
  end

  def get_player_name
    puts 'Введите имя игрока'
    gets.chomp
  end

  # подсчет очков
  def count_points
    count = 0
    @players.each { |player| count += player.count_points }
    count
  end

  def bet(bet)
    @players.each { |player| @bank += player.bet(bet) }
  end

  def have_three_card?
    flag = true
    @players.each { |player| flag &&= player.have_three_cards? }
    flag
  end

  # определение победителя
  def who_win?
    @winner = 0
    @players.each do |player|
      @winner = player if player.points <= 21 && (@winner == 0 || player.points > @winner.points)
    end
    if @winner!= 0
    puts "#{@winner.name} выиграл, у него #{@winner.points} очков"
    @winner.bank+=@bank
    else
      puts "Деньги уходят казино"
    end
    @bank = 0
  end

  def open_all
    @players.each(&:open_hand)
  end

  def show_points
    puts "Ваши очки"
    @players.each do |player|
      puts player.points unless player.class == Dealer
    end
  end

  # новая игра(сбор банка)
  def new_game
    @players = []
    @players << Player.new(get_player_name) << Dealer.new
    get_start_hand
    count_points
    bet(20) # сделать стандартную ставку
    puts "Банк: #{@bank}"
    loop do
      show_cards
      show_points
      make_move
      count_points
      puts " "
      break if have_three_card? || (@players_decision == "4") || @players_decision == "1"
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
    puts 'Для вскрытия карт нажмите 1'
    puts 'Для пропуска хода нажмите 2' if @can_pass_move
    puts 'Для набора карт нажмите 3' unless have_three_card?
    puts 'для прекращения игры нажмите 4'
  end

  # ход(сделать ход)

  def move(player)
    case @players_decision
    when '1'
      open_all
    when '2'
      @can_pass_move = false
    when '3'
      if !player.have_three_cards?
        player.get_card(@deck.get_card)
      else
        raise 'Слишком много карт'
      end
    when '4'
    else
      raise 'Неправильно выбрано действие'
    end
  end

  def make_move
    menu
    @players.each do |player|
      if player.class != Dealer
        @players_decision = get_user_action
        move(player)
      else
        player.dealers_decision(@deck.get_card)
      end
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  # запрос действия
  def get_user_action
    puts 'Выберите действие'
    gets.chomp
  end

  # отрисовать карты
  def show_cards
    @players.each(&:show_hand)
  end
end

Interface.new
