# I have not included the User class that powers these examples. Can you implement a
# User class to work with the MyClass#top_users method?


# we start with this...

class MyClass
  def top_users(users)
    users.select {|u| u.registered? && u.registered_before(3.days.ago) }.
      reject {|u| u.role == "admin" }.
      sort_by {|u| %w(email website twitter).index u.referral_stream }.
      first(5)
  end
end

# and extract a couple simple local variables...getting rid of "magic constants"
class MyClass
  def top_users(users)
    admin_role = "admin"
    referral_streams = %w(email website twitter)
    at_most_users = 5
    registration_threshold = 3.days.ago

    users.select {|u| u.registered? && u.registered_before(registration_threshold) }.
      reject {|u| u.role == admin_role }.
      sort_by {|u| referral_streams.index u.referral_stream }.
      first(at_most_users)
  end
end

# now we can do the same with that big functional-style chain
class MyClass
  def top_users(users)
    admin_role = "admin"
    referral_streams = %w(email website twitter)
    at_most_users = 5
    registration_threshold = 3.days.ago

    registered_users = users.select {|u| u.registered? && u.registered_before(registration_threshold) }
    non_admins = registered_users.reject {|u| u.role == admin_role }
    ordered_users = non_admins.sort_by {|u| referral_streams.index u.referral_stream }

    ordered_users.first(at_most_users)
  end
end

# now that we have these local variables, we might choose to extract some of them to methods
# I'll start with the simple local variables first
class MyClass
  def top_users(users)
    registered_users = users.select {|u| u.registered? && u.registered_before(registration_threshold) }
    non_admins = registered_users.reject {|u| u.role == admin_role }
    ordered_users = non_admins.sort_by {|u| referral_streams.index u.referral_stream }

    ordered_users.first(at_most_users)
  end

  def registration_threshold
    3.days.ago
  end

  def admin_role
    "admin"
  end

  def referral_streams
    %w(email website twitter)
  end

  def at_most_users
    5
  end
end


# and now we'll move those other lines into their own methods
class MyClass
  def top_users(users)
    registered_users = recently_registered users
    non_admins = all_non_admins registered_users
    ordered_users = order_by_referral_stream non_admins

    ordered_users.first(at_most_users)
  end

  private

  def recently_registered(users)
    users.select {|u| u.registered? && u.registered_before(registration_threshold) }
  end

  def all_non_admins(users)
    users.reject {|u| u.role == admin_role }
  end

  def order_by_referral_stream(users)
    users.sort_by {|u| referral_streams.index u.referral_stream }
  end

  def registration_threshold
    3.days.ago
  end

  def admin_role
    "admin"
  end

  def referral_streams
    %w(email website twitter)
  end

  def at_most_users
    5
  end
end


# Interestingly, our new class is about 4x the size of the original one, but the
# #top_users method has stayed the same number of lines
# Which is better? It's a matter of opinion... but I prefer a more readable method,
# even if that means there are more lines of code due to decomposed helper methods.
# We didn't add any logic - we just split out the logic that was there into
# well-named boundaries


# Now for some fun, we'll do one more extraction - a bonus Extract Class extraction
# I notice some subtle duplication here... the idea of passing around a list of
# users and filtering based on it. So I'll split those methods up into their own class:
class MyClass

  class UserList < Array
    def recently_registered(treshold)
      self.class.new(select {|u| u.registered? && u.registered_before(threshold) })
    end

    def all_non_role(role)
      self.class.new(reject {|u| u.role == role })
    end

    def order_by_referral_stream(referral_streams)
      self.class.new(sort_by {|u| referral_streams.index u.referral_stream })
    end
  end

  def top_users(users)
    UserList.new(users).recently_registered(registration_threshold).
      all_non_role(admin_role).
      order_by_referral_stream(referral_streams).
      first(at_most_users)
  end

  private

  def registration_treshold
    3.days.ago
  end

  def admin_role
    "admin"
  end

  def referral_streams
    %w(email website twitter)
  end

  def at_most_users
    5
  end
end

# I also find it interesting that the newly-refactored method is structurally similar
# to the original one - it is again a chain of functional-style calls, only this time
# we've encapsulated those functional-style calls into methods with intention-revealing
# names. This makes it a lot easier to understand what the code is doing, and makes it
# easier to change because we only need to locate the one method that needs to change.
# With a few small tweaks, this example could be made even more powerful by introducing
# polymorphism - can you see how to do it?
