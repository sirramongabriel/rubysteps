# Lesson 003 - TDD - Writing tiny tests

### Running the exercises

See the top-level README for how to run the exercises. This lesson's exercises
are in the `lessons/003_tdd_tiny_tests` directory.

If you run into problems, it may be because your vagrant box is out of date. You
can run `vagrant box outdated` to check, and then `vagrant box update` to update
the image. You then need to destroy your local box and restart it, with `vagrant
destroy` and `vagrant up`.

--------

# Writing Tiny Tests

I call one-line automated tests "tiny tests". The other requirement is that they
run fast. They take up a tiny bit of code, and a tiny bit of time.

I use other different kinds of tests when I work. I write tests that are a few
lines of code, or a few dozen lines of code, depending on the situation.

Tiny tests come in useful when I want to understand one small detail of a
system. I first learned about this approach via
[Giles Bowkett](http://gilesbowkett.blogspot.com), who learned it from Mike
Clark's blog post about
[documenting your knowledge of Ruby by writing unit tests](http://pragmaticstudio.com/blog/2005/3/18/ruby-learning-test-1-are-you-there-world).

--------

## Exercise 1 - Tiny tests for a big ruby

Let's start by following Giles' and Mike's lead and write some tiny tests for
parts of [Ruby core](http://www.ruby-doc.org/core). That will get you some
practice writing tiny tests on code that you might already be familiar with. If
you're not familiar with Ruby, you're in luck! I think this approach will be a
massive boost to your learning.

We're going to use the MiniTest framework - it's the closest framework to the
original Test::Unit framework and gives us a simple way to start writing tests.

I've started writing tests for some of my favorite classes and methods. Why not
visit the documentation for each class and write your own tests? Or take a look
at classes that I haven't covered here?

* `exercise_1a_array_test.rb` contains tiny tests for
  [Array](http://www.ruby-doc.org/core-2.1.2/Array.html)
* `exercise_1b_string_test.rb` contains tiny tests for
  [String](http://www.ruby-doc.org/core-2.1.2/String.html)
* `exercise_1c_hash_test.rb` contains tiny tests for
  [Hash](http://www.ruby-doc.org/core-2.1.2/Hash.html)
* `exercise_1d_enumerable_test.rb` contains tiny tests for
  [Enumerable](http://www.ruby-doc.org/core-2.1.2/Enumerable.html)

You can run the tests by running `ruby file_name.rb` - e.g. to run exercise 1a,
you would run `ruby exercise_1a_array_test.rb`.

On top of the core library, there's also the
[standard library](http://www.ruby-doc.org/stdlib-2.1.2/) which provides even
more functionality built-in to Ruby. Speaking of the standard library, I have to
give a shout out to the [Standard Librarians](https://twitter.com/stdlibrarians)
who are working on a project to document the standard library using interactive
lessons. I've been mentoring that group as a part of the Rails Girls Summer of
Code, and on top of building something valuable for the community, they're just
a great group of people. Check them out!

--------

## Exercise 2 - Tiny testing your own code

Of course, you don't have to stick to testing other people's code. You can use
tiny tests for your own code too. This is a great way to get started with
TDD. If you're not familiar with TDD, the basic idea is that you write the unit
test BEFORE you write the code. It's kind of trippy if you haven't done it
before. Don't wait for me to show you - have a go at what you think I mean, and
next week we'll look at TDD in more depth.

This week, take a look at `exercise_2_custom_code_test.rb` for examples of
custom code covered by tiny tests.

--------

## Exercise 3 - A tiny testing framework

So far we've used the Minitest testing framework for our tiny tests. I've shown
you the bare minimum you need to start writing tests, because it's important
that you learn to do what you can with what you have available. There's a lot of
other great stuff in Minitest, and a lot of other great test frameworks you can
use (see the resource section at the end of this lesson), but it's important to
remember that you can get a lot of mileage out of the most basic tools.

In this exercise, we'll build a simple testing framework to see what's going on
under the hood. We're not going to build a comprehensive framework - again, for
now we're just going to stick to the absolute minimum you need in order to make
progress.

Based on the previous examples, we really only need one method. Here's an
example of how I'd like to use it:

```ruby
verify "1 is #odd?" do
  1.odd?
end
```

Take a look at `exercise_3a_tiny_test_framework.rb` for an initial
implementation.

That's actually all we need for a decent test framework - a little syntactic
sugar over exception raising is all it takes. Everything else is just icing on
the cake.

One problem with our tiny test framework though is that it quits as soon as a
test fails, because of the raised exception. Run `ruby
exercise_3b_tiny_test_failure.rb` to see what I mean.

When you run it, you'll see that the first test fails and then quits
immediately. This isn't terrible, but it can be very nice to have a list of all
the tests that fail during one run - sometimes the fact that three specific
tests failed helps you pinpoint an error.

Let's change the test framework to print out test failures, and continue to run
other tests. See `exercise_3c_tiny_test_reporting.rb` for an implementation.

Okay, now I have a challenge for you: can you get the test framework to report
the number of passing and failed examples when it finishes running?

## Exercise 4 - Evaluate your framework options

I don't have any code for you in this exercise. Instead, we're going to go in
the opposite direction from our uber-minimal tiny testing framework, and look at
some of the different options you have in the Ruby world.

Automated testing is a critical skill for computer programmers, and top Ruby
shops always want to know that you've had some experience with writing unit
tests, integration tests, and more. The vibrant testing culture in the Ruby
community has spawned many different tools that can help your work, and your
task for this exercise is to take a look at the different options and start
experimenting with them. Read the documentation, download the tools and write
tests using them, and develop an initial impression of these tools. It doesn't
particularly matter which one you pick - each one has some popularity in the
Ruby community, and the skills you use from learning one will transfer over as
you learn other ones. You can always change your opinion later on: for now, just
start by taking a look at what's available and seeing what appeals to you.

Here are some options to check out. If you know of more, please email me and I
will add them here.

- [minitest](https://github.com/seattlerb/minitest)
- [RSpec](http://www.rspec.info)
- [Cucumber](http://cukes.info)

I'll go into more detail on some of these tools in later lessons, but I want to
make sure you know what's out there and start experimenting for yourself!

--------

# Wrap up

We didn't "do TDD" in this lesson. I wanted to hold off on that for a bit and
introduce the absolute fundamentals of automated testing. In my opinion, they
are the ability to work in tiny steps, and understanding the output from a test
framework.

Whether you've been doing TDD for a long time, or you have no idea what I'm
talking about, I hope I've shown you how you can write tiny tests to focus on
one small aspect of a system. I find these sorts of tests invaluable in my work,
because although there are a lot of different pieces to understand, I'm able to
understand each one on its own when I need to.

In future TDD lessons, we'll look at some of the benefits of writing these kinds
of tiny tests. We'll also investigate test frameworks even further, finding out
what makes them work under the hood, and the different strengths and weaknesses
of each tool.

Please take what you've learned today and experiment with writing tiny
tests. Whether you do it only to document libraries you know, or apply it to
your professional work, I promise you will learn a lot!

--------

## References

* [Microtests](http://geepawhill.org/?p=41) - GeePawHill
* [Documenting your knowledge via tests](http://pragmaticstudio.com/blog/2005/3/18/ruby-learning-test-1-are-you-there-world) - from Mike Clark
* [My friend Bobby's exploration of this practice](https://github.com/bomatson/drumming-rails/tree/master/spec_the_std_lib/rspec)
* [The rules of unit tests](http://www.artima.com/weblogs/viewpost.jsp?thread=126923) - Michael Feathers
* [UnitTest](http://c2.com/cgi/wiki?UnitTest) on the c2.com wiki
* [Integrated tests are a scam](http://www.jbrains.ca/series/integrated-tests-are-a-scam) - JB Rainsberger
