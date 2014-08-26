def verify(name, &block)
  raise "Failed test: #{name}" unless block.call
end

verify "1 is #odd?" do
  1.odd?
end

verify "2 is #even?" do
  2.even?
end
