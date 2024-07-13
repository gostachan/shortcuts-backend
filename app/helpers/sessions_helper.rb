module SessionsHelper
  def login(user)
    reset_session
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    # NOTE: 条件式で代入している, 右辺がnilの時は実行されず, 条件がfalse扱い
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(cookies[:remember_token])
        login user
        @current_user = user
      end
    end
  end

  def logged_in?
    # todo: current_user.any? これで動けば変更する
    !current_user.nil?
  end

  def forget_cookies(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def logout
    # SEARCH: session[:user_id] = nil ではなく reset_session を利用するメリットは
    forget_cookies(current_user)
    reset_session
    @current_user = nil
  end


end
