filename = ARGV[0]
$stdin.reopen filename
secrets = $stdin.read
puts "Your secret diary:"
puts secrets
