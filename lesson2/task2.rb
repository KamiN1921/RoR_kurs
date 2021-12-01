#Заполнить массив числами от 10 до 100 с шагом 5


numbers = (10..100).to_a
numbers.delete_if { |num| num % 5 !=0 }.each { |num| puts num }


# более стандартное решение
=begin
numbers = [10]
i=0
until numbers[i] == 100
  numbers.push(numbers[i] + 5)
  i+=1
end

numbers.each { |num| puts num }
=end