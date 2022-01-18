# frozen_string_literal: true

class Dealer < Player
  def initialize
    super 'Dealer'
  end

  def show_hand
    puts "Диллер: "
    @hand.each { puts '*' }
  end

  def open_hand
    puts "Ваша рука: "
    @hand.each do |x, y|
      puts "#{x}: #{y}"
    end
  end

  def dealers_decision(card)
    get_card(card) if @points <= 17
  end
end
