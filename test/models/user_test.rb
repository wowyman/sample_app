require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(name: "Weed test aaaaaaaaaaaaa", email: "weed1@gmail.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "          "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "          "
    assert_not @user.valid?
  end

  test "name length" do
    @user.name = "a" * 99
    assert_not @user.valid?
  end

  test "email length" do
    @user.email = "a" * 99
    assert_not @user.valid?
  end

  test "email formatter valid" do
    valid_address = %w[user@gmail.com User@ccc.com User@foo.com weed@gmail.com]
    valid_address.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password non-blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticate? shoud return false for a user with nil digest" do
    assert_not @user.authenticated?("")
  end
end
