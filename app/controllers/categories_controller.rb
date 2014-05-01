class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /categories
  def index
    @categories = Category.where({:user_id => current_user.id}).order(:is_income)
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    @category = Category.where({:id => params[:id], :user_id => current_user.id}).first
    if not @category
      redirect_to categories_url, alert: "Category with id = '#{params[:id]}' not found!"
    end
  end

  # POST /categories
  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id
    if @category.save
      redirect_to categories_url, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      redirect_to categories_url, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:name, :is_income)
    end
end
