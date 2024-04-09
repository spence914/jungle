class Admin::DashboardController < ApplicationController
  def show
    @product_count = Product.all.count
    @categories_count = Category.all.count
  end
end
