# Lesson 005 - Refactoring - Refactoring with Simple Rules

### Running the exercises

See the top-level README for how to run the exercises. This lesson's exercises
are in the `lessons/005_refactoring_simple_rules` directory.

If you run into problems, it may be because your vagrant box is out of date. You
can run `vagrant box outdated` to check, and then `vagrant box update` to update
the image. You then need to destroy your local box and restart it, with `vagrant
destroy` and `vagrant up`.

--------

# Refactoring to learn, via simple rules

Most people I know describe refactoring as "Improving the design of existing
code" - it probably has something to do with that phrase being the subtitle of
Martin Fowler's book titled, funnily enough: "Refactoring".

If you press people a bit further, they might tell you that you must not change
the behavior of the code at all. Refactoring is only about improving the
internal structure of code without changing its externally visible behavior.

That second statement has always puzzled me. I know what they mean...I think. As
a programmer, if I refactor some code, then users of the software should never
know I made any changes. That is, their experience of the software system should
be exactly the same it was before. That's sensible enough, but it still leaves
me wondering - how do we define behavior? Where do we draw the lines defining
what's externally visible and what's not?

When working with code, we are constantly shifting among different levels of
abstraction. Each concept in a system - each class, method, object, module - has
some externally visible behavior. The combination of these behaviors support yet
more complex behaviors, that are externally visible from a different level of
abstraction. To satisfy the property of changing structure without changing
externally visible behavior, we first need to understand what we mean by
externally visible behavior.

--------

## Exercise 1 - Identifying messages and outcomes

In order to change the structure of code without changing its behavior, we need
to understand what behavior we want to maintain. As I mentioned, this can be
tricky because it all depends on the level of abstraction that we're working at.

Over the years, I have found it useful to think of any software component in
terms of the messages it supports and the outcomes that result as it handles
those messages. This thinking works whether you're looking at a tiny method in a
system, or the system as a whole. Always ask yourself: "What messages can I
send? How does it respond to those messages?"

Messages are relatively easy - we looked at them yesterday in Lesson 004 - OOP -
Messaging. The two basic components of a message are its name, and the arguments
passed to that message. Of course, there's also the receiver of the message
which actually determines how to handle that message at runtime.

Outcomes can be quite a bit trickier to determine. Some are fairly obvious -
things like printing stuff to the screen, saving something to a file or a
database, or sending an email. Some are less obvious - a message gets sent to
some object, whether an instance variable or an object passed in via message
args, and that message has a side-effect that we can't really see.

Sometimes, outcomes are easy to understand. Methods that simply compute and
return a value are a great example of this. They only have one outcome - the
return value - even if that outcome might change a bit based on the args going
in. There are no other outcomes to worry about. For this reason, methods that
simply compute values tend to be easy to reason about, to use, and to refactor.

Please take a look at `exercise_1_intent.rb` for examples of methods that you
might consider refactoring. In each case, write a comment about the outcomes of
that method. I have provided my answers in `exercise_1_intent_answers.rb`.

--------

## Exercise 2 - Extracting things for fun and profit

By far the most common and powerful refactoring techniques I use are relatively
simple extractions - extracting variables, methods, and classes. Today we're
just going to look at extracting variables and methods, because they give us a
great starting point for following JB Rainsberger's two rules of simple design.

What are JB Rainsberger's two rules of simple design, you ask? They are, simply:

1. Remove duplication
2. Improve names

Could that really be enough to achieve a simple design? What about design
patterns? What about SOLID?

In my experience, these two rules are a great starting point for improving your
design skills. He actually distilled them down from Kent Beck's four elements of
simple design, claiming that two of Kent's are obvious or redundant. It's great
to study SOLID, and to be familiar with design patterns, but from a day-to-day
perspective I get a lot of mileage out of JB's simple rules. That's great,
because they're a lot easier to remember than some of the other things out
there.

So how does it work? Basically, duplication and bad names are two sources of the
most confusion for programmers. Bad names obscure intent. They make it difficult
to understand not only what the code actually does, but what it was meant to
do. Buggy code by definition doesn't work the way that it's supposed to, and
tough-to-read code tends to be buggy code. That's a double whammy, because not
only does the code not work the way it should, but you'll have a tough time even
figuring out what it's meant to do.

Bad names are tough enough, but duplication is even worse. At least with a bad
name, I can fix it relatively quickly and move on. The problem with duplication
is that you only *think* you've fixed something. Perhaps you did, but you only
did it in one place. Or you did it in in three places, and still missed one.

Duplication tends to arise when we need to execute a piece of existing logic,
but we don't have an easy way to get at it at run time. Instead of changing the
code's structure to support reuse, we simply copy the code from one place to
another, half-verify that it works, and call it good. In addition to missing
places to update logic, duplication can make it difficult to even understand
where to find the relevant logic in the first place. I once worked on a legacy
Rails project with ~80k lines of `app/` code, and tons of duplication. My pair
and I spent three days working on a bug, which was a simple one-line fix,
because the code that we needed to work on was duplicated about 50 times in the
project. We simply didn't know which instances we needed to change, and trying
to test our changes was a giant PITA (of course there were no automated tests!)

My other favorite thing about JB's rules are that they are inherently
subjective. What I might consider duplication, you might consider expressive and
explicit. What I might consider a bad name, you might consider terse and clear,
or perhaps you're familiar with naming conventions that I'm not. This actually
holds true for principles like SOLID as well - even programmers who understand
it deeply might not agree on where to draw the lines around a single
responsibility. Following two rules gives us a lot less to argue about, and
we're forced to explain ourselves in that context rather than appealing to SRP
or OCP or some other **P that we probably can't agree on.

Basically, I treat principles like SOLID as a way of communicating about code,
and a rubric for evaluating code. I don't treat SOLID as a target to shoot
for. My daily target is constantly changing, and I need guidelines that will
help me quickly make decisions that improve my lot in life, no matter how
little.

So with that, take a look at `exercise_2_extractions.rb`. In this exercise, I
demonstrate the two simple refactorings I use most often - extract variable, and
extract method. I wanted to provide you with simple examples so that you can use
them on exercise 3, where I've turned things up quite a bit...

--------

## Exercise 3 - Refactor to learn

My key problem with the common definition of refactoring - "improving the design
of existing code without changing its behavior" - is that you might not know
what good or bad design is yet! I've given you two incredibly useful simple
rules, but have fully admitted that the application of those rules is entirely
subjective. Moreover, as you continue to practice, your feelings on what
constitutes duplication, bad names, and good/bad design in general, will change.

I went to a great workshop recently hosted by Llewellyn Falco and Woody Zuill
about refactoring code that you don't understand. They said that you don't have
to understand what code does in order to be able to refactor it. In fact, it's
through a process of refactoring that you are able to learn more about code. I
hadn't thought of it that way before, but when I considered my own experience, I
realized how right they were. Whenever I get stuck about how to change a piece
of code, or am baffled by what a piece of code does, I start to refactor. I
don't make any major changes, I just make the smallest changes that I think make
sense. Those quickly add up over time, and I start to develop insight into the
code.

Refactoring to learn about code works for two reasons. One, it's active
reading. You're not just reading something with the hopes of understanding it,
you're reading something with the intention of making a small change that will
improve your understanding of it. This forces you to consider what each and
every line might be doing, rather than "getting the gist of things" and then
plowing along.

Second, it works because you are reinvesting your understanding back into the
system. If you read a variable name and don't know what it does, but you have a
vague idea, you can change the variable name and now the system and your
understanding of it are a little bit closer. There are two critical concepts to
understand here. The first is the idea of reinvesting knowledge into a system -
I will get into this in later lessons, but basically this is how you're able to
add tremendous value as a programmer. Second is the idea of working in small
steps - whenever you get stuck, think of how you can work in small steps that
you understand in order to make progress. This is basically the driving force
behind all the work I do as a programmer - sometimes people think I'm insane for
the tiny steps I take, but then they see how quickly I move and how I'm never
confused, and they see the power of it.

In this exercise, I've written some code that I'm not particularly proud of. In
fact, it's kind of tough to even know what it does. I want you to refactor it,
however you see fit. Hey, you've been asking for more challenging exercises,
right? :) Take a look at `exercise_3_refactor_this.rb` to see the code. Use the
two rules of simple design, and the refactorings you've learned so far (plus any
you're already familiar with), to gradually make sense of this code. You can
take it as far as you like, or just make one or two changes. If you want to
share your answers with the group, take a look at the file
`005_refactoring_simple_rules/member_answers/README.md`

--------

# Wrap up

In this lesson, we got our feet wet with refactoring. I showed you some of the
difficulties that I have with the popular notion of refactoring, and I figure
that if I have some difficulties, then other people probably do too!

Now I can share my personal working definition of refactoring with you - "the
habit of making small changes to code that advance my understanding of it."
That's it, honestly. The point of refactoring code is to make it easier to
understand and change if needed. Often times you need to change code, but you
don't yet understand what it does. In situations like this, you can start
refactoring, and if you treat it as a habit of making small changes to advance
your understanding, then you will necessarily make small improvements that lead
to understanding the code well enough that you can reason about it and change
it.

Finally, I just want to make a quick note of what refactoring is not, because I
hear this horrible definition getting thrown around a lot: refactoring is NOT
taking a big chunk of time to rework some code that you don't
understand. Almost everywhere I've worked, I've heard someone say something to
the tune of, "Yeah that feature's done, but I'm going to need about a week to
refactor it." That's not refactoring. That's not even close. That's a tacit
acknowledgment that you managed to get something working - you think, anyway -
and that you're scared of ever having to touch it again.

Expert refactoring is a HABIT, plain and simple. You do habits automatically, without
thinking. If you develop the habit of refactoring, you will soon start to reap
rewards as you continue to invest knowledge in your software system and make it
easier to understand and change, automatically and nearly without
thinking. Small changes over time add up to big results.

In future lessons, we will go into more depth about refactoring, and start to
develop a practice of habitual refactoring.

--------

## References

* [Refactoring](http://martinfowler.com/books/refactoring.html) - Martin Fowler
* [Principles of OOP (including SOLID)](http://c2.com/cgi/wiki?PrinciplesOfObjectOrientedDesign)
* [Kent Beck four elements of simple design](http://xprogramming.com/classics/expemergentdesign/)
* [JB Rainsberger two rules of simple design](http://blog.thecodewhisperer.com/2013/12/07/putting-an-age-old-battle-to-rest/)
* [Practical Refactoring](http://agile2013.sched.org/event/f96f49feb5ae4d880ad608cfc90ed867#.U9x4M1YWGuc) - Llewellyn Falco & Woody Zuill
