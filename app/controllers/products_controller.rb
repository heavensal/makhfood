class ProductsController < ApplicationController
  def index
    @products = if params[:q].present?
                  @q.result(distinct: true)

                else
                  Product.all
                end
  end


  # def create

  # end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
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
    respond_to do |format|
      format.html { redirect_to root_path }
      format.turbo_stream { render :destroy, locals: { product: @product } }
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :sku, :ean, :unit_price, :unit, :box, :price_per_unit, :tva, :mesure_unit, :ht_box_price, :ttc_box_price, :description, :specification, :conditionning, :link)
  end
end
