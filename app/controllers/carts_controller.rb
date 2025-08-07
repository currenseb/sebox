class CartsController < ApplicationController
  before_action :require_authentication

  def show
    @cart = current_user.cart
    @cart_items = @cart.present? ? @cart.cart_items.includes(:product) : []
  end

  def current_cart
    current_user.cart || current_user.create_cart
  end

end
