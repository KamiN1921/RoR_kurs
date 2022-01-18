# frozen_string_literal: true

class Player
  attr_accessor :hand
  attr_reader :points

  def initialize(name)
    @bank = 100
    # рука(массив карт на руке)(3)
    @hand = []
    # имя
    @points = 0
    @name = name
  end

  # взять карту
  def get_card(card)
    @hand << card
  end

  # открыть карты
  def show_hand
    @hand.each do |x, y|
      puts "#{x}: #{y}"
    end
  end

  def open_hand
    show_hand
  end

  # ставка
  def bet(bet)
    @bank - bet
    bet
  end

  def have_three_cards?
    @hand == 3
  end

  def count_points
    @hand.each do |card|
      if card[0].to_i >2 && card[0].to_i <10
        @points +=  card[0].to_i
      else
        @points +=  10
      end
    end
    @points
  end
end
