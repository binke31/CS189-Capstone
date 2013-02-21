require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  fixtures :all
  
  test "Home page is visible only to users" do
    visit "/home"
    assert_equal new_user_session_path, current_path
  end

end