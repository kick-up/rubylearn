#{begin
  #puts 'Before'
 # Math.sqrt(-1)
#rescue StandardError => e
  #puts "Exeption!!"
 # raise
  
#rescue NoMemoreErrod => e 
 #  puts "No memery"

#end

#puts "AFTER"}

#def method_with_error
  #....
 # raise ArgumentError, "Oh,no!"
#end

#begin
 # method_with_error 
#rescue RuntimeError => e
 # puts e.inspect
#end

#puts "AFter"

#def sqrt(value)
 # sqrt = Math.sqrt(value)
  #puts sqrt
#rescue StandardError 
 # puts "ssss"
#end

#sqrt(-1)


def connect_to_wikipedia
  #....
  raise "Connect"
end 


attempt = 0
begin
  connect_to_wikipedia 
rescue RuntimeError
  attempt += 1
  puts "Check"
  retry if attempt < 3
ensure
 puts "There was #{attempt} attempts"
end
















