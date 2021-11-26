while line = Readline.readline("> ")
  begin 
    puts eval(line).inspect
  rescue => e
    puts e.to_s + "\n" + e.backtrace.join("\n")
  end
end