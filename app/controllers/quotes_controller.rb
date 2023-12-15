class QuotesController < ApplicationController
  def show
    @quote = Quote.find(session[:quote_id])
    @quote_items = @quote.quote_items
    @products = @quote.products
  end
end
