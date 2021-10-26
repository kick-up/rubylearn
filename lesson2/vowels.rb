hash = {}

vowels = "a", "e", "i", "o", "u", "y"

alphabet = ('a'..'z')

alphabet.each.with_index(1) do |letter, index|
hash[letter] = index if vowels.include?(letter)
end

puts hash
