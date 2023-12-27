class QuotesController < ApplicationController
  def show
    @quote = Quote.find(session[:quote_id])
    @quote_items = @quote.quote_items.includes(product: [:category, :brand]).sort_by { |item|
      [item.product.category.name, item.product.brand.name]
    }
    @products = @quote.products
  end

  def update
    @quote = Quote.find(session[:quote_id])
    @quote.update(quote_params)
    if @quote.save
      redirect_to quote_path
    else
      redirect_to root_path
    end
  end

  def send_my_quote
    @quote_id = Quote.find(session[:quote_id])
    QuotesMailer.send_quote(@quote_id).deliver_now!
    redirect_to root_path
  end

  def edit

  end

  def quote_params
    params.require(:quote).permit(:first_name, :last_name, :phone, :address, :company)
  end

end
