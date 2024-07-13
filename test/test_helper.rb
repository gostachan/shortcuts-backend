ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)
  fixtures :all

  # CHECK: sessionだけでなくcookiesも管理しなくては?
  def is_logged_in?
    !session[:user_id].nil?
  end

  # def log_in_as(user)
  #   session[:user_id] = user.id
  # end

end

class ActionDispatch::IntegrationTest

  def log_in_as(user, password: 'password', remember_me: true)
    post login_path, params: { login_info: { email: user.email,
                                             password: password,
                                             isChecked: remember_me } }
  end

end
