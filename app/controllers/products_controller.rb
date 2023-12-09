class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def boissons
    @products = Product.includes(:category).where(categories: { name: "Boissons" })
  end

  def show
    @product = Product.find(params[:id])
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path status: :see_other
  end
end
