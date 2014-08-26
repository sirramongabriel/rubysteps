require 'minitest/autorun'

class StringTest < Minitest::Test
  def test_new_string_equals_empty_string
    assert(String.new == "")
  end

  def test_capitalize_downcases_all_but_first
    assert("hello Pat how are you?".capitalize == "Hello pat how are you?")
  end

  def test_downcase_makes_all_letters_small
    assert("Hi I LOVE RubySteps".downcase == "hi i love rubysteps")
  end

  def test_gsub_substitutes_string
    assert("I dislike RubySteps".gsub("dislike", "love") == "I love RubySteps")
  end

  def test_string_interning
    assert("I know that 1 + 1 = #{1 + 1}" == "I know that 1 + 1 = 2")
  end

  # Check out http://www.ruby-doc.org/core-2.1.2/String.html for even more methods...
end
