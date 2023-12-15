class ApplicationController < ActionController::Base
  before_action :search
  before_action :initialize_quote

  private

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
