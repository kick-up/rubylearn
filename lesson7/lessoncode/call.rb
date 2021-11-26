class MethodCall
  def initialize(sym, args)
    @sym = sym
    @args = args
  end
  
  def sym
    @sym
  end
  
  def args
    @args
  end
  
  def ==(other_call)
    @sym == other_call.sym && @args == other_call.args
  end
end

class Spy
  def initialize
    @method_calls = []
  end
  
  def method_missing(sym, *args, &block)
    @method_calls << MethodCall.new(sym, args)
  end

  def method_called?(sym, *args)
    @method_calls.include?(MethodCall.new(sym, args))
  end
end





class Agent
  def initialize(name)
    @name = name
  end

   def perfect(args)
    @arg = args
  end

end  

class Cpy
  def initialize(enemy_agent)
    @enemy_agent = enemy_agent
  end

  def method_missing(method_name, *args, &block)
    @enemy_agent.send(method_name, *args)
  end
end


hash = {a: 2, b: 1, c: 5}

class Hash
  def method_missing(name)
    self[name.to_sym] || self[name.to_s] || super
  end
end

#hash.a => 2