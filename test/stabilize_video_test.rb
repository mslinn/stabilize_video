require_relative 'test_helper'

class StabilizeVideoTest < Minitest::Test
  def test_it_is_a_module
    assert_kind_of Module, StabilizeVideo
  end

  def test_that_it_has_a_version_number
    refute_nil ::StabilizeVideo::VERSION
  end
end
