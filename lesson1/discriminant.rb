puts "Укажите три коэфициента:"

puts "A:"
a = gets.to_i

puts "B:"
b = gets.to_i

puts "C:"
c = gets.to_i

discriminant = b ** 2 - 4 * a * c 

if discriminant > 0 
  sqrt = Math.sqrt(discriminant)
  x1 = (-b + sqrt) / (2 * a)
  puts "Корень X1 равен #{x1}"
  x2 = (-b - sqrt) / (2 * a)
  puts "Корень X2 равен #{x2}"
elsif discriminant == 0
  x1 = - b / (2 * a)
  puts "Корень X1 = X2"
else 
  puts "Корней нет"
end

