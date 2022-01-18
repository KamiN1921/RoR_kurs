class Deck
  #взять карту
  def get_card
    @cards.pop
  end
  #созжание колоды
  def initialize
    @cards = []
    decks = "23456789TJQKA"
    suits = "thdp" #+,<З ,<>, ^
    decks.each_byte do |deck|
      suits.each_byte do |suit|
        @cards << deck.chr + suit.chr
      end
    end
    replace_suits
    @cards.shuffle!.reverse!.shuffle!.reverse!.shuffle!
  end

  def replace_suits
    @cards.values.each do
      case self
      when "t"
        self = "+"
      when "h"
        self = "<3"
      when "d"
        self = "<>"
      when "p"
        self = "^"
      end
    end
  end

end
