# Lesson 002 - Rails - Piecing together MVC

### Running the exercises

See the top-level README for how to run the exercises. This lesson's exercises
are in the `lessons/002_rails_mvc` directory.

If you run into problems, it may be because your vagrant box is out of date. You
can run `vagrant box outdated` to check, and then `vagrant box update` to update
the image. You then need to destroy your local box and restart it, with `vagrant
destroy` and `vagrant up`.

--------

# The Way Rails Does Model-View-Controller

MVC in Rails means two things to me. First, it means a pattern of organizing
code in a Rails application. Second, it means the framework components that
simplify the more mundane aspects of web application development, such as
database access and parsing HTTP requests.

--------

## Exercise 1 - Control all the things ##

When you want to enable an interaction over the web, you will define
controllers. Controllers handle requests and generate responses using the HTTP
protocol. Rails has a module that simplifies this -
[ActionController](http://guides.rubyonrails.org/action_controller_overview.html). Your
controllers will inherit from
[ActionController::Base](http://api.rubyonrails.org/classes/ActionController/Base.html). This
gets you query parameter parsing, access to session and cookie data, and request
and response headers all for free.

Controllers have a great deal of power all on their own. In this exercise, we'll
look at a few things you can do with nothing but controllers.

Run the Rails server on vagrant. Make sure you've got vagrant running and have
SSHed in:

```
vagrant up
vagrant ssh
```

Once inside, change to the lesson 2 demo app directory and start the server:

```
cd /vagrant/lessons/002_rails_mvc/demo_app_002/
rails s
```

Vagrant has mapped port 3000 from the virtual machine to your host machine. This
lets you access the running web server from your web browser. Visit
`http://localhost:3000/secrets1/jay` in your browser. You should see the text
"hey brother". `http://localhost:3000/secrets1/bj` shows "how's the baby?" and
`http://localhost:3000/secrets1/mom` shows "I love you! I'll call you later".

It's a simple little application that shows a secret message to people. All
people have to do to get the latest message from me is visit their custom
URL. Take a look inside `app/controllers/secrets1_controller.rb` to see how it
works.

We can make another application to do some basic math for us. Try visiting the
following URLs in your browser:

```
http://localhost:3000/maths/add?num1=1&num2=2
http://localhost:3000/maths/subtract?num1=6&num2=2
```

Take a look in `app/controllers/maths_controller.rb` to see how they work.

That's a very simple example, but we can build on it a bit and even make some
kind of an interface while sticking exclusively to controllers. Visit the url
`http://localhost:3000/maths2` and click around a bit. After you've done that,
look at `app/controllers/maths2_controller.rb` to see how it works.

--------

## Exercise 2 - views ##

In the previous exercise, I showed how you can build a simple application using
only controllers. Now I'd like to add views to the mix. Views only exist because
of controllers - they provide a place for us to put code that would make the
controllers too difficult to understand. If you try to render all of your HTML
from within a controller, it will get pretty ugly pretty quickly. By moving code
into views, we're able to make the controllers easier to understand. It also
allows for things like
[ERB](http://www.ruby-doc.org/stdlib-2.1.2/libdoc/erb/rdoc/ERB.html), which
simplify things even further - we can write our view code like an ordinary HTML
page, and embed Ruby code when we want to.

In this exercise, we'll move all that logic out of the controllers and build
the adding application entirely out of views.

Visit `http://localhost:3000/maths3` and you'll see it works just like the
previous example. If you look inside `app/controllers/maths3_controller.rb`
though you might be surprised to find that it's almost entirely empty! Well I
told you that we'd be using views only, so maybe it's not that much of a
surprise. The application works because Rails will render a view associated with
a particular action, even if that action isn't defined. By defining the views
for add and subtract, and moving the logic into them, we have an application
with the same behavior as before only now with a controller that doesn't do
anything. You can find the views in `app/views/maths3`.

Why not try building an interface to the secret diary? Maybe you could add a
simple per-user password check.

--------

## Exercise 3 - models

In the first exercise, we looked at how to build an application using only
controllers. In the second exercise, we used the bare minimum controller
possible and built an application entirely using views. In this exercise, we'll
introduce a simple model. The model will serve as a place to hold the
application logic.

Open your browser to `http://localhost:3000/maths4` and you will see the
familiar adding and subtracting application. If you take a look inside
`app/controllers/maths4_controller.rb` you'll see a new class defined in
it. Ordinarily in a Rails app you would place your model classes inside the
`app/models` folder, but I wanted to show that there's nothing particular
special about a model class. Here I'm just using a simple Ruby class to hold
onto the math-specific behavior that I care about.

I've hooked up the calls to this model using the view - take a look inside
`app/views/maths4` and you will see how the linking is done.

We can actually ditch the view all together, and not have any specialized
controller actions. For the last math session of the day, visit
`http://localhost:3000/maths5`. Run through it again, and then take a look at
`app/controllers/maths5_controller.rb`. You'll see the same Calculator model,
but this time the controller is hooking things up by dynamically sending
messages to the calculator. We actually pass along the method names as part of
the link!

--------

# Wrap up

I've only scratched the surface of what's possible by following MVC conventions
in Rails. I've shown you examples here that aren't typical of Rails
applications. I take that back: I've seen plenty of people write their entire
application in the controller or the view, it was just a really bad idea :) My
point here is not to suggest that you start cramming all the logic in one place,
but to show you how Controllers, Views and Models are split up, and that you can
do a great deal by focusing on only one of the parts. Ultimately you will decide
the best place for your code, and understanding that you can place code wherever
you like is the first step in making good decisions long-term.
