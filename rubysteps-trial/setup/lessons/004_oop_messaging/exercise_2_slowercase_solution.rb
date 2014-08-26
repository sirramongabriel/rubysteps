def slowercase(a_string)
  # sleep for 3 seconds
  sleep 3
  # return a lowercase version of the string
  a_string.downcase
end

puts slowercase(ARGV[0])
