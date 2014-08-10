require 'minitest/autorun'

class RubySteps
  def fun!
    true
  end

  def educational?
    true
  end

  def about
    ['ruby', 'rails', 'tdd', 'oop', 'refactoring']
  end
end

class RubyStepsTest < Minitest::Test
  def test_ruby_steps_is_fun
    assert(RubySteps.new.fun! == true)
  end

  def test_ruby_steps_is_educational
    assert(RubySteps.new.educational? == true)
  end

  def test_ruby_steps_is_about_good_stuff
    assert(RubySteps.new.about == %w(ruby rails tdd oop refactoring))
  end
end
