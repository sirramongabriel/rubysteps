class MyClass
  def say_hello
    puts "hello"
  end

  def to_proc
    lambda { say_hello }
  end
end

def do_call(&block)
  block.call
end

do_call &MyClass.new
