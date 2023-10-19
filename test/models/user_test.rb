require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "username" do
    assert_equal "john", users(:johndoe).username
  end
end
