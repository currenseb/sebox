class PagesController < ApplicationController
  def home
    @products = Product.all
  end

  def contact

  end

  def product_params
    params.require(:product).permit(:name, :description, :featured_image, :inventory_count, :price)
  end
end
