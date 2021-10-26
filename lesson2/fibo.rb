# Заполнить массив числами фибоначчи до 100
fibo = [0,1]
next_count = 1

while next_count < 100 
  fibo << next_count
  next_count = fibo [-1] + fibo [-2]
end

