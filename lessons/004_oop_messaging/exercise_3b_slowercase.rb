class Slowercase
  def initialize(slower, caser)
    @slower, @caser = slower, caser
  end

  def slowercase(a_string)
    @slower.slow
    @caser.lowercase a_string
  end
end

class Slower
  def slow
    sleep 3
  end
end

class Lowercaser
  def lowercase(a_string)
    a_string.downcase
  end
end

class Trowercaser
  def lowercase(a_string)
  end
end

puts Slowercase.new(Slower.new, Lowercaser.new).slowercase("FuNkYcAsE")

# Can you implement Trowercaser#lowercase and make it work? Hint: look at String#tr

# Can you create a new class similar to Slower, which returns immediately, and
# switch on a command-line arg?
