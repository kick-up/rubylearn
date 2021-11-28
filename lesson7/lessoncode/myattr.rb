# class Foo
#   def initialize
#     @bar = "instance var"
#   end

#   private

#   def private_method
#     puts "I'm private method"
#   end
# end


class Y
  define_method(:my_method) do
    puts "my mehod"
  end
end

#y.my_method
#my mehod
    


module MyAttrAccessor
  def my_attr_accessor(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) { |value| instance_variable_set(var_name, value) }
    end
  end
end

class Test
  extend MyAttrAccessor

  my_attr_accessor :my_attr, :a, :b, :c
end


class X
  def m 
    puts "hello"
  end

  def method_missing(name, *args)
    puts "call #{name} with arg #{arg}"
  end
end

#x.m = > hello
#x.abc = > Call abc with arg []


class X
  def method_missing(name, *args)
    self.class.send(:define_method, name.to_sym, lambda {|*args| puts args.inspect})
  end
end

#x.abc 1,2,3 => [1,2,3]