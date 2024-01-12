class BrandsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @brands = Brand.all
  end

  def show
    @brand = Brand.find(params[:id])
    @products = @brand.products
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    if @brand.save!
      redirect_to brand_path(@brand)
    end
  end

  def edit
    @brand = Brand.find(params[:id])
  end

  def update
    @brand = Brand.find(params[:id])
    @brand.update(brand_params)
    if @brand.save
      redirect_to brand_path(@brand)
    end
  end

  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy
    redirect_to brands_path
  end

  private

  def brand_params
    params.require(:brand).permit(:name)
  end

end
