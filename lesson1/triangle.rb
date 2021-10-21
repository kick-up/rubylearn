puts "Укажите основание треугольника в сантиметрах:"
base = gets.chomp.to_f

puts "Укажите высоту треугольника в сантиметрах:"
height = gets.chomp.to_f

area = 0.5 * base * height

puts "Площадь треугольника равна #{area} сантиметров"
