puts "Введите первый коэффицент уравнения"
a = gets.to_f
puts "Введите второй коэффицент уравнения"
b = gets.to_f
puts "Введите третий коэффицент уравнения"
c= gets.to_f

d = b**2 - (4* a*c)

if(d<0)
  puts "уравнение не имеет корней"
elsif(d==0)
  puts "Корень уравнения #{-b/(2*a)}"
else
  puts "x1 = #{(-b+Math.sqrt(d))/(2*a)}"
  puts "x1 = #{(-b-Math.sqrt(d))/(2*a)}"
end