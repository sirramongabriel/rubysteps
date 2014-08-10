class Add10
  def +(number)
    10 + number
  end
end

p(Add10.new + 5)

class RandomList
  def [](count)
    list = []
    count.times { list << rand(100) }
    list
  end
end

p(RandomList.new[3])

class Summing
  def initialize(value)
    @value = value
  end

  def &(other)
    self.class.new(@value + other.to_i)
  end

  def inspect
    "@value = #{@value}"
  end

  def to_i
    @value
  end
end

p(Summing.new(1) & 2 & 3)


# we can really mess with people here!
class Fixnum
  def +(other)
    self - other
  end
end

p(10 + 5)
