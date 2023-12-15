class QuoteItemsController < ApplicationController

  def create
    @quote = Quote.find(session[:quote_id])
    @product = Product.find(params[:product_id])
    @quote_item = QuoteItem.new(quote_id: @quote.id, product_id: @product.id)
    if @quote_item.save
      redirect_to quote_path
    end
  end

  def update
  end

  def destroy
  end
end
