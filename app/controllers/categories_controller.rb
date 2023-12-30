class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @brands = @category.brands
    @products = @category.products
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save!
      redirect_to category_path(@category)
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params)
    if @category.save
      redirect_to category_path(@category)
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categorys_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end


end
