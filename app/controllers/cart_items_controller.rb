class CartItemsController < ApplicationController
  before_action :require_login

  def create
    product = Product.find(params[:product_id])

    if product.inventory_count.to_i <= 0
      redirect_to product_path(product), alert: "Sorry, this product is out of stock."
      return
    end

    cart = current_user.cart
    item = cart.cart_items.find_or_initialize_by(product_id: product.id)
    item.quantity ||= 0
    item.quantity += 1
    item.save!
    redirect_to product_path(product), notice: "Added to cart!"
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

