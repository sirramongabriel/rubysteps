def slowercase(a_string)
  # sleep for 3 secondds
  # return a lowercase version of the string
  sleep(3)
  a_string.downcase
end

puts slowercase(ARGV[0])
