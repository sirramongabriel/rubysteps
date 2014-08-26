require 'minitest/autorun'

class EnumerableTest < Minitest::Test
  def test_all_is_true
    assert([1,3,5,7].all?(&:odd?))
  end

  def test_all_is_false
    assert(![1,2,3].all?(&:odd?))
  end

  def test_any_is_true
    assert([1,2].any?(&:odd?))
  end

  def test_any_is_false
    assert(![2,4].any?(&:odd?))
  end

  def test_select_chooses_items
    assert([1,2,3,4,5].select(&:odd?) == [1,3,5])
  end

  # Lots more in http://www.ruby-doc.org/core-2.1.2/Enumerable.html
end
