class ApplicationController < ActionController::Base
  before_action :search
  before_action :initialize_quote
  before_action :initialize_db

  private

  def initialize_db
    @products = Product.includes(:category, :brand)
    @categories = Category.all
    @brands = Brand.all
  end

  def initialize_quote
    if session[:quote_id].blank?
      @quote = Quote.create
      session[:quote_id] = @quote.id
    end
  end

  def search
    @q = Product.ransack(params[:q])
  end
end
