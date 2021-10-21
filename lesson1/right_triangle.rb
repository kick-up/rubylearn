puts "Укажите сторону A треугольника в сантиметрах:"
a = gets.to_i

puts "Укажите сторону B треугольника в сантиметрах:"
b = gets.to_i

puts "Укажите  сторону C треугольника в сантиметрах:"
c = gets.to_i

cathetus1, cathetus2, hypotenuse = [a,b,c].sort!
right_triangle = cathetus1 ** 2 + cathetus2 **2 == hypotenuse ** 2

if cathetus1 == cathetus2
  puts "Этот треугольник является равнобедренным"
elsif right_triangle
  puts "Этот треугольник является прямоугольным"
else
  puts "Этот треугольник не является прямоугольным"
end
