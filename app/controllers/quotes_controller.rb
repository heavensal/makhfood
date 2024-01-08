class QuotesController < ApplicationController
  before_action :set_or_create_quote, only: [:show, :edit, :update, :send_my_quote]

  def show
    @quote_items = @quote.quote_items.includes(product: [:category, :brand]).sort_by { |item|
      [item.product.category.name, item.product.brand.name]
    }
    @products = @quote.products
  end

  def edit
  end

  def update
    if @quote.update(quote_params)
      redirect_to quote_path
    else
      render :edit
    end
  end

  def send_my_quote
    QuotesMailer.send_quote(@quote).deliver_now!
    redirect_to redirect_path
    new_quote = Quote.create!
    session[:quote_id] = new_quote.id
  end

  private

  def set_or_create_quote
    @quote = Quote.find_by(id: session[:quote_id]) || Quote.create!
    session[:quote_id] = @quote.id
  end

  def quote_params
    params.require(:quote).permit(:first_name, :last_name, :phone, :email, :address, :company)
  end

end
