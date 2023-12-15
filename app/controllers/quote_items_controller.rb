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
    @quote_item = QuoteItem.find(params[:id])
    @quote_item.update(quote_item_params)
    if @quote_item.save
      redirect_to quote_path
    else
      redirect_to root_path
    end
  end

  def destroy
  end

  private

  def quote_item_params
    params.require(:quote_item).permit(:quantity)
  end
end
