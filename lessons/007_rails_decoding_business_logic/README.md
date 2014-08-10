# Lesson 007 - Rails - Decoding Business Logic

### Running the exercises

See the top-level README for how to run the exercises. This lesson's exercises
are in the `lessons/007_rails_decoding_business_logic` directory.

If you run into problems, it may be because your vagrant box is out of date. You
can run `vagrant box outdated` to check, and then `vagrant box update` to update
the image. You then need to destroy your local box and restart it, with `vagrant
destroy` and `vagrant up`.

--------

# Decoding Business Logic

Business logic is generally broken down into two kinds of logic - application
logic and domain logic. Domain logic represents the aspects inherent to the
problem - you might draw flow charts or simulate structures and behaviors with
people using index cards, pretending that no application will ever
exist. Application logic makes that domain logic available to people or systems
in a way that they can interact with. Ideally, they get some value from it.

The business of software boils down to automating things. We automate business
processes that generate positive outcomes. Every software project is an
investment. Personal projects you do as you learn represent an investment of
your time and energy. You put that time in with the expectation that it will pay
off in some way, whether by helping you get your first programming job or your
last, open new doors for you, or just satisfy your curiosity in some way. If you
think of your personal projects in terms of the return they provide, you will
have at least done something to prepare yourself for work as a professional
programmer and know what's expected of you.

If you're already working, then you can benefit from thinking about the
economics of software projects. Your work represents an investment by the
company, hoping for some return, which might be generally known or might not. A
startup that sells tickets will hope their efforts result in ticket sales. A
startup that is looking to grow a big user base will hope the investment results
in getting a truckload of users every day.

Economic realities play out at all levels, at the VC and startup world, the
"lifestyle businesses", and every moment you sit at the keyboard writing code,
or are away from it thinking of how to move the project forward.

The most basic way we can deliver business value is to automate something that
we're doing that delivers value - that or eliminate something wasteful.

What does all that have to do with business logic? We can amplify our delivery
of business value by understanding the business logic. We can create systems
that are easy to understand and maintain, and to extend as we wish. We can build
small, powerful systems that work correctly and deliver tons of value to people
and businesses.

In today's lesson, I want you to try to tie business logic and business value
together. Try to see where the domain lies, and where the application
lies. Experiment with the systems and see what they communicate to you. Think of
whether you'd be able to add anything, or change it so that you learn something.

--------

## Exercise 1 - Modeling the Domain Logic

A few people are confused about the lessons. They don't quite understand what to
do or what to get out of them. Some also wonder whether they should move on to a
lesson before they've fully understood the previous one.

We experience time linearly (mostly), but learning is not a linear process. I
cannot give you the steps to get from point a to point b. Everyone is walking
their own path. They'll have to take their own steps. The RubySteps prorgram is
about finding their own steps, with help and support from me and the whole
community, every step of the way.

Still, I can see how it will be useful to get a bit more direction. Here's a
simple thing I suggest before every learning session: write a couple questions
down that you want answered as part of the session. One is fine, and I would do
no more than three.

Go through the lesson and make notes as they relate to your questions. If you
come up with more questions, write them down for later. For now, you'll focus on
answering the questions you recorded at the start of the session.

Of course, it would be great to be able to recall those notes easily, keep track
of our progress within the course, and maybe even link and search questions and
notes. You can do all of that without a computer. You can write down your notes,
file them away, and search them, but a computer can do that a lot faster. So let's
build a little program that simulates what we go through in this course. It will
be a tool to manage your progress, and you can extend it as the course goes
on. I'll start with a simple model of the domain. I like using this technique I
learned from Llewelyn Falco and Woody Zuill. I'll write out a basic scenario in
English - a simple story - of what happens as I go through the program.

* I receive a lesson each day.
* I begin working on a lesson.
* I write 1-3 questions before working on the lesson.
* I work through the lesson, taking notes as they relate to my questions.
* I finish the lesson, and mark each question as answered or not.

That's a pretty good start. As with anything written though, we can refactor
it. I'm looking for things that don't reflect a particular action.

* *I receive a lesson each day.* - from where?
* *I begin working on a lesson.* - what does that mean? where are you?
* *I write 1-3 questions before working on the lesson.* - are the questions part
  of "working on the lesson"?
* *I work through the lesson, taking notes as they relate to my questions.* - this
  makes sense to me, mostly
* *I finish the lesson, and mark each question as answered or not.* - what does it
mean to finish a lesson? does marking each question mean the lesson is finished,
or is that one part of finishing the lesson?

I'm only going to refactor this a bit, to remove parts that I don't want to work
on right away, and to expose some clear actions.

* I fetch the latest lesson each day.
* I start a new learning session.
* I write 1-3 questions.
* I read the lesson and take notes relating to my questions
* I mark each question as answered or not
* I mark the learning session as finished.

Using that as a starting point, I've started to convert each line to a starting
message name.

```ruby
fetch_latest_lesson
initiate_learning_session
record_questions
take_notes_on_questions
mark_questions_as_answered
mark_session_as_finished
```

I don't know yet what the objects might be, but this is a decent start. I do
notice some interesting duplication among the message names though -
learning\_session, question, mark. I'll play with those names a bit and see if
they might make sense on some objects.

```ruby
lessons.fetch_latest
learning_session.initiate
questions.record
notes.record
questions.mark_as_answered
learning_session.mark_as_finished
```

That's just a slightly different way of thinking about the messages. If we
organize them a bit more, we get:

```ruby
lessons.fetch_latest

learning_session.initiate
learning_session.mark_as_finished

questions.record
questions.mark_as_answered

notes.record
```

That looks like a reasonable possible model to me, based on the English version
of the story. I don't like those dangling lessons and notes objects though, so
I'm going to refactor those a bit more:

```ruby
learning_session.initiate
learning_session.choose_lesson
learning_session.mark_as_finished

questions.record
questions.mark_as_answered
questions.record_notes
```

Now let's say that we want to write an application that enables this basic
learning session process. It walks you through each step of the process, from
fetching the lesson to marking your learning session as complete. If we just
have these methods, how do we ensure that everything gets run in the right
order?

A state machine can help us here. A state machine defines possible states, and
the possible ways to transition among those states. For example, it could be
possible to transition from a state "learning\_session\_initiated" to
"choosing\_lesson" but not vice-versa - in this case, we want the flow to go one
way from top to bottom. We transition from one state to another via events -
message sends to the object.

Take a look at `rubysteps_progress/app/models/learning_session.rb` to see an
example of a learning session modeled as a state machine.

This particular state machine shows domain logic - it defines the allowable
possible transitions. It doesn't make sense for us to ask questions before
choosing the lesson (or does it? this is what we need to determine when we model
a domain). I have chosen to go with a strict model at this point, only allowing
linear transitions to keep things simple.

One important aspect of any model is that you can interact with it. Whether you
model something with index cards or with code, you can interact with the model
and test it out. Open up the Rails console by running `rails c` and you can step
through an entire learning session (you may need to run `bundle update` to
install the latest gems if you have an out of date vagrant box):

```ruby
irb(main):012:0> session = LearningSession.new
=> #<LearningSession:0x007ff18d1ac620 @state="unstarted">
irb(main):013:0> session.start
=> true
irb(main):014:0> session.choose_lesson
=> true
irb(main):015:0> session.record_questions
=> true
irb(main):016:0> session.record_notes
=> true
irb(main):017:0> session.mark_questions_as_answered
=> true
irb(main):018:0> session.finish_session
=> true
```

If we call any method out of order, the method will return false to indicate
that it cannot make the transition.

```ruby
irb(main):019:0> session = LearningSession.new
=> #<LearningSession:0x007ff18d1456a0 @state="unstarted">
irb(main):020:0> session.start
=> true
irb(main):021:0> session.record_questions
=> false
```

--------

## Exercise 2 - Putting it Together with Application Logic

Application logic makes the domain logic available to people or other
computers. Application logic enables new kinds of interactions. Application
logic is the stuff that reads parameters, interacts with a persistence layer,
sends emails, etc. It is all the stuff that enables humans and computers to
interact with the business logic and derive business value from it. With a clean
domain layer, we can write new kinds of application logic to enable new kinds of
interactions.

Last week we talked about MVC and how there really are no rules when it comes to
placing logic - you can put it just about anywhere you want. You might find that
following a couple guidelines helps, though:

* Put domain logic in the model
* Put application logic in the controllers, helpers, and views

That's it really.

I don't draw the model boundaries around persistence. I would ordinarily
consider persistence to be an application concern. It's not something you would
care much about as part of modeling the domain. However, ActiveRecord implements
the Active Record pattern which describes persistent objects with some domain
logic. ActiveRecord makes it easy to create persistent models. Not all of the
model needs to be persistent though, and we can use ActiveRecord for the parts
when we need persistence, and not use it otherwise.

Application logic necessarily knows about the domain. It exposes the domain, so
it has to have enough knowledge of how and why to interact with it. Domain logic,
on the other hand, typically doesn't need to know about application logic.

We can write a simple application using this domain logic. Take a look around
the rails app and see what you can find. It's small, so you shouldn't get
lost. Here's a hint: all the good stuff is in the `app/` folder :)

You can run the Rails web server with `rails s`, and then visit
 `http://localhost:3000` in your browser - if you get an error about the port,
 you can change it directly in the Vagrantfile and halt and start the box
 again. You don't have to destroy it.

Check out `http://localhost:3000/learning_session/new` where you can walk
through the basic steps of a learning session. It demonstrates how the
application logic, defined by the controller code and view code, uses the simple
domain model we created to enable a new kind of interactive application.

The domain model ensures integrity. The application logic can call methods out
of order, but it won't have any effect other than to show an error message. Try
changing one of the event names in the views, or the allowed transitions in the
model.

I have not added any persistence here - that would be a good next thing for you
to do. Then you can keep a learning journal of your work with RubySteps (or any
learning material), all using a simple system that you can build on and maintain.

--------

# Wrap up

My purpose here has been to demonstrate the value of understanding how to
separate business logic into its primary components of domain logic and
application logic. People new to Rails tend to think along the lines of
"database stuff goes in the model, web stuff goes in the controller, and
anything left over goes in lib". You can use that approach, and it can work, and
I've certainly done my share of it. There's nothing really wrong with that
approach. However, it tends to conceal useful aspects of our software, such as
the business rules and any infrastructure dependencies. By thinking in terms of
domain logic and application logic, you can represent business rules in domain
logic. You can then expose that domain logic via application logic, and create
new interactions. The domain layer typically does not know anything about
application logic or infrastructure - instead, the application logic
orchestrates any interaction between the user, the domain logic, and any
necessary infrastructure.

--------

## References

- [Business Logic Definition](http://c2.com/cgi/wiki?BusinessLogicDefinition) - c2.com (whoa! aren't you glad I gave you the condensed version? ;)
- [Domain Object](http://c2.com/cgi/wiki?DomainObject) - c2.com
- [Hexagonal Architecture](http://alistair.cockburn.us/Hexagonal+architecture) - Alistair Cockburn
- [Active Record pattern](http://martinfowler.com/eaaCatalog/activeRecord.html) - Martin Fowler PoEAA
