class StoreController < ApplicationController
  skip_before_action :authorize

  include CurrentCart
  before_action :set_cart

  def index
    if params[:set_locale]
      redirect_to store_index_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)

      session[:counter] = 0 if session[:counter].nil?
      session[:counter] += 1

      @user_visit = session[:counter]
    end
  end
end
