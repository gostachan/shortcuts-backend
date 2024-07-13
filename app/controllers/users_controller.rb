class UsersController < ApplicationController
  def create
    user = User.new(signup_info)
    if user.save
      login user
      render json: { user: user }, status: 201
    else
      render json: { message: user.errors.messages }, status: 422
    end
  end

  private

    def signup_info
      params.require(:signup_info).permit(:email,
                                          :password,
                                          :password_conformation)
    end
end
