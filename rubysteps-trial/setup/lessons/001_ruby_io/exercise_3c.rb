require 'io/console'

puts "Write down whatever you like, your secret's safe with me"
entry = $stdin.noecho &:gets

$stdout.reopen 'secretdiary', 'a' # 'a' means append to the file if it exists
puts entry

$stdout.reopen '/dev/tty'
puts "I've recorded the entry, safe and sound"
