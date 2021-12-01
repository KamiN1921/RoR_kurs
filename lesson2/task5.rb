=begin
5. Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
 Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным.
=end
count_of_days =[ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
day = 0
month = 0
year = 0
leap = false
  loop do
  puts"Введите число отличное от 1..31"
  day = gets.chomp.to_i
  puts"Введите месяц (число 1..12)"
  month = gets.chomp.to_i
  puts "Введите год  больше 0"
  year = gets.chomp.to_i
  if (year % 400 == 0)||(year % 4 == 0 && year % 100 == 0)
    leap = true
  end
    if (year > 0)&& (day > 0 && (leap && month==2 && day<=29)||(day<=count_of_days[month-1]) )&&(month>0 && month<=12)
    break
  else
    next
    end
  end

  date = 0
 for i in (0..month-2) do
    date+=count_of_days[i]
 end
date+=day
if(leap&& month>2)
  date+=1
end
puts "Порядковый номер дня #{date}"