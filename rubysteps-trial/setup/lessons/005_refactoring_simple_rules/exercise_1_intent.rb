class Foo
  def something(bar)
    bar.do_something
  end
end

class Account
  def initialize
    @balance = "0"
  end

  def deposit(amount)
    amount.times { @balance.succ! }
  end

  def balance
    @balance.to_i
  end
end

def downcased_email(username, domain)
  [username, domain].map(&:downcase).join "@"
end

def copy_lines_matching(infilename, outfilename, regex)
  lines = File.readlines(File.expand_path(infilename)).select {|l| regex.match l }
  File.open(File.expand_path(outfilename), 'w') do |file|
    lines.each {|l| file << l }
  end
end
