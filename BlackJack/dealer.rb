class Dealer

  def initialize
    @name = "Dealer"
  end

  def show_hand
    @hand.each {puts "*" }
  end

  def open_hand
    @hand.each do |x,y|
      puts "#{x}: #{y}"
    end
  end

  def dealers_decision(card)
    if(@points<=17)
      get_card(card)
    end
  end



end
