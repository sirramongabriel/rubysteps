# Lesson 004 - OOP - Messaging

### Running the exercises

See the top-level README for how to run the exercises. This lesson's exercises
are in the `lessons/004_oop_messaging` directory.

If you run into problems, it may be because your vagrant box is out of date. You
can run `vagrant box outdated` to check, and then `vagrant box update` to update
the image. You then need to destroy your local box and restart it, with `vagrant
destroy` and `vagrant up`.

--------

# Messaging - The Big Idea

All communication in computers happens via messaging. As I type this, digital
data is being messaged from my keyboard to my computer. The operating system
uses a series of internal messages to make sense of the data, and then sends
that data to other software via messages. The software interprets the data via
messages, and invokes behavior via messages. Yet more messages get sent in order
to make the characters appear on-screen.

In case you haven't got it: the big idea is messaging. When I talk about
software design, I mean the definition and delineation of messages within a
system. Messages need senders and receivers to be useful, so we must also
consider those as a part of software design.

In this lesson, we will look at messaging in Ruby. We will look at the syntax
for defining different types of messages. We will see how Ruby implements
various messages. We will see how the idea of messaging enables us to write
simple, powerful software.

--------

## Exercise 1 - Taking a look at Ruby's messages

In this exercise, we'll look at some of the different ways you can send messages
in Ruby. Once we've done that, we'll implement some of those messages ourselves
to see how they work.

First off, you need to understand that every message we send has a receiver. You
might also hear this called the target or the object. If you don't specify a
receiver, the message will be sent to self. In this case, we say "self is the
implicit receiver of the message".

For example, the two following lines are equivalent:

```ruby
foo
self.foo
```

In each case, the message `#foo` is being sent to the object `self`. `self` is a
reference to the object that is currently handling the program's messages. If
that doesn't make sense to you yet, don't worry, you'll see plenty of examples
to make it clearer.

Run `ruby exercise_1a_self.rb` and look inside to see an example of messages
being sent to self, along with an implicit self receiver.

We can pass arguments to messages. These arguments get passed along to the
object that handles the message. They're how you share data between one message
handler and another. The handler could be an object, a method, or block - don't
worry about that for now, because the point is that messages are a loose idea
that enable a powerful interaction style.

Run `ruby exercise_1b_arguments.rb` and look inside for examples of sending
messages with arguments.

Math and logic operators are simply messages sent to objects. You can define
your own implementations of these messages, or overwrite the existing ones. Run
`ruby exercise_1c_operators.rb` and look inside for examples of defining
operator-style methods.

--------

## Exercise 2 - Defining our own messages

Sending messages to built-in Ruby messages is cool, but at some point we'll want
to define our own messages. When we do, we will implement these messages via
methods.

In this exercise, we'll create a simple program I call Slowercase. The program
accepts input, and prints out a lowercase version of the input...after waiting
for a little while.

We could dive into writing code, but this time we'll start off with defining the
messages we want the program to use. Thinking of the messages helps us identify
the core responsibilities of the program. We're just trying to think of the
different things it can do, not thinking about where to define the messages.

The only message that I care about right now is `slowercase(a_string)`. Run
`ruby exercise_2_slowercase.rb FuNkYcAsE` - it should immediately print out the
string "FuNkYcAsE". I've placed two comments in the `slowercase` method - try
replacing the comments with appropriate message sends. If you can't figure it
out, you can take a look at `exercise_2_slowercase_solution.rb` for a solution.

--------

## Exercise 3 - Introducing polymorphism

Messages enable us to separate the interactions in a system from the code that
makes those interactions possible. We define interactions via the set of
messages allowed, and then implement those messages via methods. Different
objects may have different implementations. This allows us to write code that
sends messages without caring about how the message is actually carried
out. This can result in clear code that is easy to extend over time.

When we send a message in Ruby, we're taking advantage of polymorphism - the
ability for multiple objects to respond to one message in different ways. In the
Ruby world, we call this duck-typing: "If it walks like a duck, and quacks like
a duck, then we can treat it as a duck."

`exercise_3a_polymorphism.rb` shows a simple example of polymorphism. The
`#print_a_line` method sends a single message: `#print_line`, and we have two
different implementations of it. You can create new implementations and pass
them in to `#print_a_line` in order to achieve new behavior without changing the
original implementation. This is an example of using collaborating objects.

Let's revisit the slowercase program and make it polymorphic. I want to try
different implementations of downcasing a string. Take a look at
`exercise_3b_slowercase.rb` and you will see that I've extracted the delay and
lowercase responsibilities to their own objects. This enables polymorphism, and
if you look at the comments you'll see some ideas on new implementations to take
advantage of the polymorphism. If you want to see how I've done it, take a look
at `exercise_3b_slowercase_solutions.rb`. You can run it with the `-f` flag with
`ruby exercise_3b_slowercase_solutions.rb -f`.

## Exercise 4 - #call and #to_proc

There's one particular message in Ruby that I really like: `#call`. The most
common objects you'll come across that implement `#call` are Proc
objects. You'll typically get a reference to a Proc object via a block passed in
to a method.

It's also possible to obtain a reference to an object's instance method. It's a
bit weird, but it allows you to pass around a reference to the method and call
it later via `#call`. You can also implement `#call` on your own classes,
because it's a normal Ruby method. Take a look at `exercise_4b_call.rb` for an
example of using callable objects in Ruby.

Finally, the `#to_proc` method gives us a way of converting one object to a
Proc, so it becomes callable in some way. It's the trick that enables syntax
like `[1,2,3].select(&:odd?)` - it ends up calling `Symbol#to_proc`. Take a look
at `exercise_4c_to_proc.rb` for an example of using this method.

--------

# Wrap up

We've looked at the most important part of object-oriented-programming: the big
idea of messaging. We've looked at how we can send different kinds of messages,
and how we can define new implementations for our own messages. We've seen how
messaging allows polymorphism - which itself allows us to write clear programs
that are easy to extend. Finally, we looked at a few powerful messages in Ruby -
`#call` and `#to_proc` - that provide a single interface that we can use to
write simple, extensible code.

Messages form the core of any software system. When you design, you will
primarily be defining the various messages, and how to delineate groups of
messages from one another. When people first start learning about OOP, they go
crazy with classes - they define lots of different classes and create huge
inheritance heirarchies. They focus on the wrong thing - classes are little more
than a place to put a set of messages that go together. Focus on the messages -
the interactions within a system - and you will be able to easily change the
class structure that supports them because everything communicates by way of
well-defined messages.

--------

## References

* [The Big Idea is Messaging](http://c2.com/cgi/wiki?AlanKayOnMessaging) - Alan Kay
* [Object#send](http://www.ruby-doc.org/core-2.1.2/Object.html#method-i-send)
* [Proc](http://www.ruby-doc.org/core-2.1.2/Proc.html)
* [Symbol#to_proc](http://www.ruby-doc.org/core-2.1.2/Symbol.html#method-i-to_proc)
* [Duck-typing](https://en.wikipedia.org/wiki/Duck_typing)
* [Polymorphism and Ruby](http://robots.thoughtbot.com/back-to-basics-polymorphism-and-ruby) - Thoughtbot
* [Object collaboration stereotypes](http://www.mockobjects.com/2006/10/different-kinds-of-collaborators.html) - Steve Freeman
