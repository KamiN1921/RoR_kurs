puts "Добрый день, как Вас зовут?"
name = gets.chomp
puts "Приятно познакомиться! Укажите ваш рост, пожалуйста"
height = gets.chomp

perfect = (height.to_i - 110)* 1.15
if perfect>0
  puts "#{name.capitalize}! Ваш идеальный вес: #{perfect}."
else
  puts "#{name.capitalize}, Ваш вес уже оптимален!"
end

