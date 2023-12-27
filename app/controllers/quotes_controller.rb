class QuotesController < ApplicationController
  def show
    @quote = Quote.find(session[:quote_id])
    @quote_items = @quote.quote_items.includes(product: [:category, :brand]).sort_by { |item|
      [item.product.category.name, item.product.brand.name]
    }
    @products = @quote.products
  end

  def edit
    @quote = Quote.find(session[:quote_id])
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to edit_quote_path }
    end
  end

  def update
    @quote = Quote.find(session[:quote_id])
    if @quote.update(quote_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to quote_path(@quote) }
      end
    else
      render :edit
    end
  end

  def send_my_quote
    @quote_id = Quote.find(session[:quote_id])
    QuotesMailer.send_quote(@quote_id).deliver_now!
    redirect_to root_path
  end

  def quote_params
    params.require(:quote).permit(:first_name, :last_name, :phone, :address, :company)
  end

end
