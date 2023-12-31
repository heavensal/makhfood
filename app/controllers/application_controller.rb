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
    return if session[:quote_id].present?
    @quote = Quote.find_or_create_by(id: session[:quote_id])
    session[:quote_id] = @quote.id
    @quote_items = @quote.quote_items
  end

  def search
    @q = Product.ransack(params[:q])
  end
end
