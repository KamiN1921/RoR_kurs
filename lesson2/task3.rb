#Заполнить массив числами фибоначчи до 100

arr=[0,1]
i = 2
until arr[i-1]>=100
  arr.push(arr[i-2]+arr[i-1])
  i+=1
end
arr.each { |x| puts x }