class CartItemsController < ApplicationController
  def create
  unless current_user
    redirect_to new_session_path, alert: "You must be logged in to add items to your cart."
    return
  end

  cart = current_user.cart || current_user.create_cart
  product = Product.find(params[:product_id])

  item = cart.cart_items.find_or_initialize_by(product: product)
  item.quantity ||= 0
  item.quantity += 1
  item.save!

  redirect_to product_path(product), notice: "Added to cart!"
end



def destroy
    item = current_user.cart.cart_items.find(params[:id])
    item.destroy
    redirect_to cart_path
  end
end
