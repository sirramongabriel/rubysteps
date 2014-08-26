class Foo
  def something(bar)
    # send a message to a passed in object. Impossible to know whether it has any side effects!
    bar.do_something
  end
end

class Account
  def initialize
    @balance = "0"
  end

  def deposit(amount)
    # send a message to an internal state-changing object
    # admittedly you would not typically see this kind of an implementation, but I wanted to
    # illustrate an example of state-changing methods on instance variables
    amount.times { @balance.succ! }
  end

  # compute and return a value, easy!
  def balance
    @balance.to_i
  end
end

# compute and return a value
def downcased_email(username, domain)
  [username, domain].map(&:downcase).join "@"
end

# write out to a file
# other possible outcomes could be error messages if the file doesn't exist, or the
# user doesn't have permission to read or write
def copy_lines_matching(infilename, outfilename, regex)
  lines = File.readlines(File.expand_path(infilename)).select {|l| regex.match l }
  File.open(File.expand_path(outfilename), 'w') do |file|
    lines.each {|l| file << l }
  end
end
