puts "Введите ваше имя"
name  =  gets.chomp.capitalize!

puts "Введите ваш рост"
height  =  gets.chomp.to_i

ideal_weight  =  ((height - 110) * 1.15).to_i

ideal_weight < 0
  puts "#{name} ваш вес уже оптимальный"
else
  puts "#{name} ваш идеальный вес #{ideal_weight}"
end


