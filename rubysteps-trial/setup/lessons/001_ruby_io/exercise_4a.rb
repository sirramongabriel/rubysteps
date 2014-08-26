filename = ARGV[0]
$stdin.reopen filename
secrets = gets
puts "Your secret diary:"
puts secrets
