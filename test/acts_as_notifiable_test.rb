require 'test_helper'

class ActsAsNotifiableTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, ActsAsNotifiable
  end
end
