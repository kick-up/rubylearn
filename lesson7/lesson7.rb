#Ниже это блок как аргументы методов

3.times do |x|
  puts x   
  end

3.times { |i| puts i}

def m(i) #аргументы блока или переменные блока
  puts i
end

for i in 1..3
  m(i)
end
 
h = {a:1,b:1,c:3}

#если принимает один аргумент будет передаваться массивы
h.each do |value| 
  puts value.inspect
end
#[:a, 1] #массив содержит ключ значение два элемента
#[:b, 2]
#[:c, 3]

#в каждый аргумент будет записываться ключ и значение 
h.each do |key,value|
  puts "#{key} = > #{value}"
end
#a = > 1

[1,2,3,4].each  { |i| puts i * 20}

#если некий код нужно сохранить в переменную 
#иногда можно использовать можно создать ХЭШ 
#ключами которого являются те значение которые туда приходят
#а значением собственно код который нужно выполнить


#если некий код нужно сохранить в переменную 
#обьект
a = Proc.new {|i| i = i * 10; puts i}
b = proc {|i| i = i * 10; puts i}
c = lambda {|i| i = i * 10; puts i}

a.call(100)
#1000


#как обьект еще и сохраняет область видимости обьявленные переменные
x = "Hello"
block  = proc {puts x} 

block.call #Hello



def m(block)
  x = "Good"
  puts "X from met #{x}"
  block.call 
end

m(block)
#X from met Good
#Hello



def m 
  puts "Before"
  yield 
  puts "After"
end

m { puts "inside"} #вызывает не как именнованный аргумент

#Before
#Inside
#After

#вызывает не как именнованный аргумент
def caps(str)
  str.capitalize!
  yield(str)
end

caps('abc') {|str| puts[0]}
#A

#вызвать как именнованный аргумент
def caps(str,block)
  str.capitalize!
  block.call(str)
end

block = lambda { |x| puts x}
caps 'abc', block
#A

#вызвать как именнованный аргумент
def caps(str, &block)
  str.capitalize!
  block.call(str)
end

caps('abc'){ |x| puts x}
#Abc

# пример другой
def caps(str, &block)
  str.capitalize!
  block.call(str)
  yield(str)
end

caps('abc'){ |x| puts x}
#Abc
#Abc

#передан либо не пердан блок в метод
def m(str, &block)
  if block_given?
    yield(str)
  else
    puts str
  end
end

m('abc')
#abc

m('abc') { |x| x.capitalize!; puts x}
#Abc
