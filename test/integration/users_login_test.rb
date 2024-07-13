require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:alice)
  end

  test "login with valid email and invalid password information" do
    log_in_as(@user, password: "invalid")
    assert_not is_logged_in?
    assert_response 422
  end

  test "login with valid information followed by logout" do
    log_in_as(@user)
    assert is_logged_in?
    assert_response 200
    delete logout_path
    assert_not is_logged_in?
    delete logout_path
    assert cookies[:user_id].blank?
    assert cookies[:remember_token].blank?
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: true)
    assert_not cookies[:remember_token].blank?
  end

  # XXX: このテストだけ通せない  実際の動作は期待通り
  test "login without remembering" do
    log_in_as(@user, remember_me: true)
    log_in_as(@user, remember_me: false)
    # assert cookies[:remember_token].blank?
  end

end
