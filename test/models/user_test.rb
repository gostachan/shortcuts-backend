require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(email: "user@example.com",
                     password: "12345678",
                     password_confirmation: "12345678")
    @password_min_length = 8
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "email should not be too logn" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[ user@example,com
                            user_at_foo.org
                            user.vame@example.
                            foo@bar_baz.com
                            foo@bar..com
                            foo@bar+baz.com ]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end


  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lowercase" do
    mixed_case_email = "Foo@ExAMPLe.Com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonvlank)" do
    @user.password              = " " * @password_min_length
    @user.password_confirmation = " " * @password_min_length
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password              = "a" * (@password_min_length - 1)
    @user.password_confirmation = "a" * (@password_min_length - 1)
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(" ")
  end

  # TODO: 擬似的にセッション固定攻撃を実装して，
  #       session_resetが行われていることをテストできない？

end
