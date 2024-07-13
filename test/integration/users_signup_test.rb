require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    assert_no_difference "User.count" do
      post users_path, params: {signup_info: { email:                 "user@invalid",
                                               password:              "foo",
                                               password_confirmation: "bar" } }
    end
    assert_response 422
  end

  # TODO: flashを実装したらしっかり表示されるかテストする

  test "valid signup information" do
    assert_difference "User.count", 1 do
      post users_path, params: {signup_info: { email:                 "user@exapmle.com",
                                               password:              "password",
                                               password_confirmation: "bapasswordr" } }
    end
    assert_response 201
    assert is_logged_in?
  end
end
