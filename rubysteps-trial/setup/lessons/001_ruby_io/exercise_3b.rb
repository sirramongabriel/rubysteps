require 'io/console' # needed for the noecho call below

puts "Write down whatever you like, your secret's safe with me"
entry = $stdin.noecho &:gets  # runs gets without echoing input to the screen

$stdout.reopen 'secretdiary' # redirect standard output to a file
puts entry

$stdout.reopen '/dev/tty' # redirect standard output to the terminal
puts "I've recorded the entry, safe and sound"
