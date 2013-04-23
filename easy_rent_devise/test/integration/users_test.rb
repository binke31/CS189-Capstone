require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  fixtures :all
  
  test "Home page is visible only to users" do
    visit "/home"
    assert_equal new_user_session_path, current_path
  end

  test "Home page is shown when valid login credentials are submitted" do
    loginAttempt("chris@horukmail.com","12345678")
    assert_equal "/home", current_path
  end

  test "Invalid login credentials leads to login page being redisplayed" do
    loginAttempt("Invalid","Credentials")
    assert_equal new_user_session_path, current_path
  end

  test "Blank credentials doesn't break anything" do
    loginAttempt("","")
    assert_equal new_user_session_path, current_path
  end

  test "User can't log in twice" do
    loginAttempt("chris@horukmail.com","12345678")
    visit "/login"
    assert_equal "/home", current_path
  end

end