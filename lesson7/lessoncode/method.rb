def monk(arg1, arg2)
  "Monks"
end

mo = self.method(:monk)
puts mo

#Мы можем сохранить этот объект и изменить его с помощью самого кода, 
#запросить его и извлечь из него полезные метаданные.
def monk(arg1, *args2)
  "Monks" + arg1 + args2.first
end

mo = self.method(:monk)

puts "Arity"
p mo.arity

puts "Parameters"
p mo.parameters

#Arity
#-2
#Parameters
#[[:req, :arg1], [:rest, :args2]]


#Значение - это символическая форма самого параметра.
class Monastery
  def monks(arg1, arg2)
    "Monks" + arg1 + arg2
  end
end

mo = Monastery.new.method(:monks)

puts "Receiver --"
p mo.receiver
#объект, к которому привязан метод

puts

puts "Owner --"
p mo.owner
#класс которому принадлежит этот объект.


#Receiver --
#<Monastery:0x00005649549edec0>

#Owner --
#Monastery


A_CONSTANT = 42
p Module.const_get('A_CONSTANT')
#42