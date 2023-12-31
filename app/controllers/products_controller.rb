class ProductsController < ApplicationController
  before_action :set_or_create_quote, only: [:show]

  def index
    @products = if params[:q].present?
                  @q.result(distinct: true)

                else
                  Product.all
                end
  end

  def show
    @product = Product.find(params[:id])
    @quote_item = QuoteItem.new
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save!
      redirect_to product_path(@product)
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    if @product.save
      redirect_to product_path(@product)
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private

  def set_or_create_quote
    @quote = Quote.find_by(id: session[:quote_id]) || Quote.create!
    session[:quote_id] = @quote.id
  end

  def product_params
    params.require(:product).permit(:name, :box, :link, :photo, :category_id, :brand_id)
  end
end
