class StoreController < ApplicationController
  skip_before_action :authorize

  include CurrentCart
  before_action :set_cart

  def index
    @products = Product.order(:title)

    session[:counter] = 0 if session[:counter].nil?
    session[:counter] += 1

    @user_visit = session[:counter]
  end
end
