require 'test_helper'

class IseqCollectorTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::IseqCollector::VERSION
  end

  def test_each_iseq
    GC.start
    iseqc = ObjectSpace.count_iseq
    ObjectSpace.each_iseq{|iseq|
      assert_kind_of(RubyVM::InstructionSequence, iseq)
      iseqc -= 1
    }
    assert_equal(0, iseqc)
  end

  def test_count_iseq
    GC.start
    iseqc = ObjectSpace.count_iseq
    binding.eval("1.times{2}")
    assert_equal(iseqc + 2, ObjectSpace.count_iseq)
  end

  def test_memsize_of_all_iseq
    size = ObjectSpace.memsize_of_all_iseq
    binding.eval("1.times{2}")
    assert size < ObjectSpace.memsize_of_all_iseq
  end
end
