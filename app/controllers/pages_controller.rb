class PagesController < ApplicationController
  def home
    @products = Product.all
  end

  def product_params
    params.expect(product: [ :name, :description, :featured_image, :inventory_count, :price ])
  end
end
