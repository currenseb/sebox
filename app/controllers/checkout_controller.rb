class CheckoutController < ApplicationController
  def create
    # Build Stripe line items from the user's cart
    checkout_items = current_user.cart.cart_items.map do |item|
      {
        price_data: {
          currency: "usd",
          unit_amount: (item.product.price * 100).to_i, # Stripe wants cents
          product_data: {
            name: item.product.name
          }
        },
        quantity: item.quantity
      }
    end

    # Create Stripe Checkout Session

    session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      line_items: checkout_items,
      mode: "payment",
      success_url: root_url + "?success=true",
      cancel_url: root_url + "?canceled=true"
    )

    # Redirect the user to Stripe Checkout
    redirect_to session.url, allow_other_host: true
  end
end

