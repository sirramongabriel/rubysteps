def verify(name, &block)
  puts "Failed test: #{name}" unless block.call
end

verify "1 is #odd?" do
  2.odd?
end

verify "2 is #even?" do
  1.even?
end
