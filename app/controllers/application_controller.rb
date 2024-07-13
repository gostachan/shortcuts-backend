class ApplicationController < ActionController::API
  include SessionsHelper
  # SEARCH: 下のコードの書くとCookiesメソッドが利用できるようになるのはなぜか？
  include ActionController::Cookies

  def set_current_user
    @user = current_user
    if @user.nil?
      render json: { message: "Authorization is requered." }, status: 401
    end
  end


end
