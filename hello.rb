puts "Как тебя зовут?"
name = gets.chomp

puts "В каком году ты родился?"
year = gets.chomp.to_i

puts "#{name}, привет! Тебе примерно #{2021 - year}"
