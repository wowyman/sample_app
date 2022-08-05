require "test_helper"

class UserInteractiveTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @user_interactive = @user.user_interactives.build()
  end

  test "should be valid" do
    assert @user_interactive.valid?
  end

  test "user id should be present" do
    @user_interactive.user_id = nil
    assert_not @user_interactive.valid?
  end
end
