class ApplicationController < ActionController::Base
  before_action :search

  private

  def search
    @q = Product.ransack(params[:q])
  end
end
