class QuotesController < ApplicationController
  def show
    @quote = Quote.find(session[:quote_id])
    @quote_items = @quote.quote_items.includes(product: [:category, :brand]).sort_by { |item|
      [item.product.category.name, item.product.brand.name]
    }
    @products = @quote.products
  end
end
