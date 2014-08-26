require 'minitest/autorun'

class HashTest < Minitest::Test
  def test_new_hash_is_equivalent
    assert(Hash.new == {})
  end

  def test_default_value_is_nil
    assert({}[:funky] == nil)
  end

  def test_set_default_value_on_initialize
    assert(Hash.new("chicken")[:funky] == "chicken")
  end

  def test_set_value_overrides_default_value
    assert(Hash.new("chicken").tap {|hash| hash[:funky] = "James Brown" }[:funky] == "James Brown")
  end

  def test_hash_with_initializer_sets_value
    assert(Hash.new {|hash, k| k.to_s.upcase }[:funky] == "FUNKY")
  end

  # Plenty more in http://www.ruby-doc.org/core-2.1.2/Hash.html
end
