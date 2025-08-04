class SessionsController < ApplicationController

  allow_unauthenticated_access only: %i[new create signup register]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    # login form
  end

  def create
    if user = User.authenticate_by(**params.permit(:email_address, :password))
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "Invalid email address or password."
    end
  end

  def signup
    @user = User.new
  end

  def register
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      @user.create_cart
      redirect_to root_path, notice: "Account created!"
    else
      render :signup, status: :unprocessable_entity
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end

  helper_method :current_user

  def start_new_session_for(user)
    session[:user_id] = user.id
  end

  def terminate_session
    reset_session
    @current_user = nil
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
