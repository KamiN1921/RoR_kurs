class Deck
  #взять карту
  def get_card
    @cards.pop
  end
  #созжание колоды
  def initialize
    @cards = []
    decks = %w[2 3 4 5 6 7 8 9 10 T J Q K A]
    suits = %w[+ <З <> ^]
    decks.each do |deck|
      suits.each do |suit|
        @cards << [deck.chr, suit.chr]
      end
    end
    @cards.shuffle!.reverse!.shuffle!.reverse!.shuffle!
    @cards.map
  end

end
