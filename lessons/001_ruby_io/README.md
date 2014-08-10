# Lesson 001 - ruby - io Playbook

### Running the exercises

See the top-level README for how to run the exercises. This lesson's exercises
are in the `lessons/001_ruby_io` directory.

# Input and Output in Ruby

Input and output drive all the software in the world. That and adding
numbers. It makes sense to start with input and output because that is how
computers communicate, whether with humans or with other computers.

I remember when I was first learning to program. I got a kick out of simply
printing different things on the screen. I would print my name, the nasty
nicknames I had for my brother, my age (when I learned how to make the computer
do math), and one time I had the computer print out every number from 0 to
infinity. It never quite made it to infinity but it was a fun program
nonetheless.

[I/O](http://www.ruby-doc.org/core-2.1.2/IO.html) is a good starting topic
because it is the foundation for all software. Whether communicating over a
terminal interface, a network connection, or a fully-blown GUI interface, you
will need to understand how to use Ruby's input and output mechanisms to share
information.

--------

## Exercise 1 - Printing with puts ##


First we'll start with the humble
[puts](http://www.ruby-doc.org/core-2.1.2/IO.html#method-i-puts). puts does one
thing, and it does it well: it prints a string representation of the objects
passed to it, followed by a newline.

```ruby
puts "Hello world"
puts Time.now
puts Array.new([1,2,3])
puts rand(128).class
```

Run exercise 1a with:

`ruby exercise_1a.rb`

`puts` calls the `#to_s` method on any passed in objects. You can define this
for classes of your own:

```ruby
class MyClass
  def to_s
    "I am a MyClass"
  end
end

puts MyClass.new
```

Run exercise 1b with:

`ruby exercise_1b.rb`

You can pass multiple objects to puts, and it will print each one on its own
line:

```ruby
puts "Hello", "testing", "puts", 12345
```

Run exercise 1c with:

`ruby exercise_1c.rb`

--------

## Exercise 2 - Getting with gets ##

Ruby provides a simple way to receive keyboard input from a user by way of the
[gets](http://www.ruby-doc.org/core-2.1.2/IO.html#method-i-gets) method. gets
returns a string object as entered by the user, including any whitespace.

```ruby
puts "What is your name?"
gets
puts "What is your quest?"
gets
puts "What is your favorite color?"
gets
```

Run exercise 2a with:

`ruby exercise_2a.rb`

Of course, input is more interesting when we do something with it. In this case,
we'll print it back out.

```ruby
puts "What is your name?"
name = gets
puts "What is your quest?"
quest = gets
puts "What is your favorite color?"
color = gets

puts "Your name is"
puts name
puts "Your quest is"
puts quest
puts "Your favorite color is"
puts color
```

Run exercise 2b with:

`ruby exercise_2b.rb`

That works, but the prompt is kind of funky. The prompt text shows on one line
and the input appears on the next line.  Fortunately there's a quick fix for
that - the [print](http://www.ruby-doc.org/core-2.1.2/IO.html#method-i-print)
method. print works the same as puts, only without printing the newline. In
other words, it simply prints out a string representation of the objects passed
to it. We can change the prompts and final output to use print so they line up
better.

```ruby
print "What is your name? "
name = gets
print "What is your quest? "
quest = gets
print "What is your favorite color? "
color = gets

print "Your name is "
puts name
print "Your quest is "
puts quest
print "Your favorite color is "
puts color
```

Run exercise 2c with:

`ruby exercise_2c.rb`

--------

## Exercise 3 - Redirecting output

You may want to send output to a file rather than to a terminal display. It's
possible to do that by running ruby from the command line and using unix i/o
redirection. Unfortunately, the command syntax varies depending on the shell you
use. Ruby has some methods built-in that you can use to set up i/o redirection
on the fly, which gives you much more power in terms of sending information
where you want it to go.

First let's just print everything to a file:

```ruby
$stdout.reopen 'exercise3.log'

puts "This is going to exercise3.log"
puts "so is this"
```

Run exercise 3a with:

`ruby exercise_3a.rb`

All of the output is saved to exercise3.log, which you can view with

`cat exercise3.log`

You can switch up the output redirection on the fly, letting you output
information to the screen, then to a file, and then back to the screen.

```ruby
require 'io/console' # needed for the noecho call below

puts "Write down whatever you like, your secret's safe with me"
entry = $stdin.noecho &:gets  # runs gets without echoing input to the screen

$stdout.reopen 'secretdiary' # redirect standard output to a file
puts entry

$stdout.reopen '/dev/tty' # redirect standard output to the terminal
puts "I've recorded the entry, safe and sound"
```

Run exercise 3b with:

`ruby exercise_3b.rb`

If you run this program multiple times, you'll find that it overwrites the
secretdiary file every time. We'd like to append to it instead, which we can do
with a simple option to $stdout.reopen

```ruby
require 'io/console'

puts "Write down whatever you like, your secret's safe with me"
entry = $stdin.noecho &:gets

$stdout.reopen 'secretdiary', 'a' # 'a' means append to the file if it exists
puts entry

$stdout.reopen '/dev/tty'
puts "I've recorded the entry, safe and sound"
```

Run exercise 3c with:

`ruby exercise_3c.rb`

After running it multiple times, you'll find each entry on its own line in the
secretdiary file.

--------

## Exercise 4 - Handling input to the program

We can pass input to programs via the command line, either using command line
arguments or the standard input. Let's make a simple program that displays the
contents of our secret diary, based on a command line argument. `ARGV` is an
array that holds onto the arguments, so we can access the first one with
`ARGV[0]`:

```ruby
filename = ARGV[0]
$stdin.reopen filename
secrets = gets
puts "Your secret diary:"
puts secrets
```

Run exercise 4a with:

`ruby exercise_4a.rb secretdiary`

If you have more than one line in your secretdiary file, you might be surprised
to see that the program only prints the first one.  This is because gets records
input until it receives a newline, and then it returns. Each entry in the
secretdiary file ends in a newline, so gets only reads the first one. We can
read the entire contents using `$stdin.read` instead.

```ruby
filename = ARGV[0]
$stdin.reopen filename
secrets = $stdin.read
puts "Your secret diary:"
puts secrets
```

Run exercise 4b with:

`ruby exercise_4b.rb secretdiary`

Unix systems allow us to specify where to read standard input as a part of
executing the program. We can read the secret diary directly from standard input
by using command line input redirection:

```ruby
secrets = $stdin.read
puts "Your secret diary:"
puts secrets
```

Run exercise 4c with standard input coming from the secretdiary file with:

`ruby exercise_4c.rb < secretdiary`

You can also redirect one program's output as the standard input of this program
using unix pipes:

`cat secretdiary | ruby exercise_4c.rb`

--------

## Wrap up ##

I have gone into a good bit of detail on the standard input and output
mechanisms in Ruby, but I've still only scratched the surface of what's
available. I would like you to look at these examples and think of how many
different programs you might be able to write using nothing but basic input and
output. You won't work this way in your day to day work, but exercising your
brain here is a great way to deepen your understanding of how people are able to
interact with computers.
