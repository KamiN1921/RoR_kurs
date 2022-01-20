# frozen_string_literal: true

class Player
  attr_accessor :hand
  attr_reader :points
  attr_accessor :bank
  attr_reader :name

  def initialize(name)
    @bank = 100
    # рука(массив карт на руке)(3)
    @hand = []
    # имя
    @points = 0
    @name = name
  end

  def new_game
    @hand = []
    @points = 0
  end

  # взять карту
  def get_card(card)
    @hand << card
  end

  # открыть карты
  def show_hand
    puts "Ваша рука: "
    @hand.each do |x, y|
      puts "#{x}: #{y}"
    end
  end

  def open_hand
    show_hand
  end

  # ставка
  def bet(bet)
    @bank -= bet
    bet

  end

  def have_three_cards?
    @hand.length == 3
  end

  def count_points
    @points = 0
    @hand.each do |card|
      if card[0].to_i >2 && card[0].to_i <10
        @points +=  card[0].to_i
      elsif card[0] =="T" && @hand.include?(card[0])
        @points +=1
      else
        @points +=  10
      end
    end
    @points
  end
end
