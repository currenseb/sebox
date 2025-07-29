class ProductMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  def default_url_options
    Rails.application.config.action_mailer.default_url_options
  end

  def in_stock
    @product = params[:product]
    @subscriber = params[:subscriber]
    @unsubscribe_token = @subscriber.generate_token_for(:unsubscribe)
    @unsubscribe_url = product_unsubscribe_url(@product, token: @unsubscribe_token)


    mail to: @subscriber.email
  end
end
