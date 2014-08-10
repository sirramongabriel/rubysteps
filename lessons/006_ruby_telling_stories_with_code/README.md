# Lesson 006 - Ruby - Telling Stories with Code

### Running the exercises

See the top-level README for how to run the exercises. This lesson's exercises
are in the `lessons/006_ruby_telling_stories_with_code` directory.

If you run into problems, it may be because your vagrant box is out of date. You
can run `vagrant box outdated` to check, and then `vagrant box update` to update
the image. You then need to destroy your local box and restart it, with `vagrant
destroy` and `vagrant up`.

--------

# Telling Stories with Code

People say "I'm coding" as shorthand for "I'm writing code". "I'm writing code"
itself is shorthand for "I am creating a set of instructions for the computer to
execute, and doing so in a way that allows me or someone else to modify that
instruction set." When I put it like that, it makes a lot more sense why people
say "I'm coding." The real thing is a mouthful.

All code tells a story. When I look back at the "Refactor This" exercise from
lesson 5, I see the story of a programmer who hates himself - or at least, will
hate himself the next time he sits down to work on the code again.

Some stories are better than others. Some storytellers are better than
others. You can get better at telling stories simply by telling stories. You
will get better at telling stories with code simply by telling stories with
code.

What makes a good story? I'm not going to speculate in general, but I will tell
you what I think makes a good code story.

A good code story tells itself. It is expressive. When I read it, I understand not
only what the story is, but why it is.

A good code story has actors. The actors have abilities and motivations. Some
actors work with one another, some don't.

A good code story has an environment. The environment provides a place for the
actors to live and interact.

A good code story has an arc. It's not quite beginning-middle-end, but it does
change and flow in a particular direction over time.

As you continue your efforts to write clean code, think of the story your code
tells. Think about whether you can clearly see the key components of actors,
environment, and arc, and that the story is expressive and tells itself. Let's
look at how to do that.

--------

## Exercise 1 - The story of the daily tracker

If you haven't figured out the story from Lesson 5, Exercise 3's code sample, it
is an exercise and food tracker. You view and add entries via the command line,
and can filter the viewed entries by date.

You can't really tell any of that from the code though, can you? MAYBE you saw
"b l d" in order and put together that it means "breakfast lunch dinner". From
there you might have figured out that "f" is a control character for "food" and
then might make the leap to "e" being a control character for "exercise". I sort
of doubt it though. I made it hard to read on purpose.

How could I make that code better? Lots of ways! Take a look at
`exercise_1_storyish.rb` to see how I've re-written the daily log program to
make the story more expressive. Can you see the actors, the environment, and the
story arc? I have implemented adding food entries, but not exercises. I have
also implemented reporting, but not the ability to limit the report to a single
day. Go ahead and add the exercise and date filtering functionality yourself.

--------

## Exercise 2 - Your own daily tracker

This second exercise is all you. Extend the daily tracker to handle more object
types than just food and exercise (if you've not added the exercise
functionality, start there). Do you have anything else you want to track
regularly? Maybe notes as you browse the web, or your progress on the RubySteps
lessons? You now have a piece of software that you can customize as you
wish. Perhaps you will find it an interesting and helpful project to work on as
you go through RubySteps. I'd love to see what you come up with!

Bonus points if you add tests :)

--------

## Exercise 3 - Write your own stories with code

You'll do this final exercise for today all on your own as well. I want you to
write stories with code. Don't worry about the code being correct, or
working. Don't even run the code. Don't even try to run the code. Focus on
writing good stories that clearly express the actors, the environment, and the
story arc. You can make them as short or long as you wish, as complete or
spartan as you wish, and as cohesive or disconnected as you wish. You can write
one and forget about it, or rewrite it as much as you want. The point is to
practice writing stories with code. You might consider sharing your code stories
with me or with other RubySteps members to see how they respond. Can they
clearly understand the story you're telling?

The more you do this, the better you'll get!

--------

# Wrap up

Programmers love clean code. Programmers love to talk about clean
code. Programmers love to talk about how to write clean code.

How do you write clean code? There's a lot of good stuff out there - SOLID, Kent
Beck's four elements of simple design, and JB Rainsberger's two rules of simple
code to name a few.

As we talked about in lesson 5, I find JB's rules of simple design remarkably
effective in helping me write clean code. They provide a simple set of questions
for me to ask myself as I code: Do I understand what this name means? Is there
any duplication?

I find SOLID especially useful for evaluating a design that already exists. I
ask myself, "Is this code SOLID?" But I haven't yet figured out a way to sit
down with the intention of writing SOLID code - other than to work according to
JB's two rules of simple design, and evaluate whether I think the code is SOLID
when I'm done.

Despite being somewhat abstract, my guidelines for evaluating stories in code
have helped me write clean, SOLID code. Once I understood that all code tells
stories, I was able to improve my ability to write clean code by thinking in
terms of the story my code tells. If I can understand the story, and I can
identify the actors and the environment and arc, then I am in a good position to
change the code how I want to. If I can't understand the story, or if I have to
spend lots of time re-learning the story each time I read it, then the cost of
change goes way up. In some cases, it might not be worth it to try to change the
code. It might not even be possible, because the story is so entangled that any
changes break the software.

As you go about your work, think of the stories being told by the code you read
and write. Try to identify the actors, environment, and arc. If you have
difficulty with anything, try to change the code to make it more
understandable. Eventually, the entire sum of all the stories you tell through
code will begin to tell a larger story - the story of a programmer who loves
what they do, and writes clean code.

--------

## References

* [Q&A w/ Matz](http://siliconangle.com/blog/2011/08/31/qa-with-yukihiro-matz-matsumoto-the-creator-of-ruby/) describing his goal in creating Ruby.
* [Clean Code](http://c2.com/cgi/wiki?CleanCode) on the c2 wiki
* [Domain-Specific Languages](http://martinfowler.com/books/dsl.html) - Martin Fowler
* [How you can learn more by writing code than by reading it](http://patmaddox.com/2014/07/30/learn-more-by-writing-code/)
