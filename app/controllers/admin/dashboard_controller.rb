class Admin::DashboardController < ApplicationController
  def show
    @products = Product.all.order(created_at: :desc)
    @category = Category.all
  end
end
