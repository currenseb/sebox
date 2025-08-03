class CartItemsController < ApplicationController
  before_action :require_login

  def create
    item = current_cart.cart_items.find_or_initialize_by(product_id: params[:product_id])
    item.quantity ||= 0
    item.quantity += 1
    item.save!
    redirect_to product_path(params[:product_id]), notice: "Added to cart!"
  end

  def destroy
    item = current_cart.cart_items.find(params[:id])
    item.destroy
    redirect_to cart_path
  end

  private

  def current_cart
    current_user.cart || current_user.create_cart
  end
end

