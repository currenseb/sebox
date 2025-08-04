class UsersController < ApplicationController
  before_action :set_user

  def edit_address
    render partial: "form", locals: { user: @user }
  end

  def update_address
    if @user.update(user_params)
      redirect_to checkout_path, notice: "Address saved!"
    else
      render partial: "form", locals: { user: @user }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:street, :city, :state, :zip)
  end
end

