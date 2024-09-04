require "test_helper"
class UserTest < ActiveSupport::TestCase
  test "should not save user without username" do
    user = User.new(
      email: "my_email@example.com",
      password: "password"
    )
    assert_not user.save
  end

  test "should not save user without email" do
    user = User.new(
      username: "my_email@example.com",
      password: "password"
    )
    assert_not user.save
  end

  test "should not save user without password" do
    user = User.new(
      email: "my_email@example.com",
      username: "username"
    )
    assert_not user.save
  end
end
