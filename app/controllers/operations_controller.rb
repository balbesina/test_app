class OperationsController < ApplicationController
  before_action :set_operation, only: [:edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :json, :js

  # GET /operations
  def index
    @operations = Operation.where({:user_id => current_user.id}).order(date: :desc)
  end

  # GET /operations/1
  def show
  end

  # GET /operations/new
  def new
    @operation = Operation.new
    @operation.user_id = current_user.id
    @operation.is_income = true
    @operation.date = DateTime.now
  end

  def ajax_categories
    @categories = Category.where("user_id = ? AND is_income = ?", params[:user_id], params[:is_income] == 'true')

    @result = ""
    for category in @categories
      @result += "<label class=\"checkbox\"><input id=\"product_category_ids_#{category.id}\" name=\"operation[category_ids][]\" type=\"checkbox\" value=\"#{category.id}\" />#{category.name}</label>"
    end

    respond_to do |format|
      msg = { :status => "ok", :message => "Success!", :html => @result }
      format.js  { render :json => msg }
    end
  end

  # GET /operations/1/edit
  def edit
    @operation = Operation.where({:id => params[:id], :user_id => current_user.id}).first    
    if not @operation
      redirect_to operations_url, alert: "Operation with id = '#{params[:id]}' not found!"
    end
  end

  # POST /operations
  def create
    @operation = Operation.new(operation_params)
    @operation.user_id = current_user.id
    if @operation.save
      redirect_to operations_url, notice: 'Operation was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /operations/1
  def update    
    params[:operation][:category_ids] ||= [] 
    if @operation.update(operation_params)
      redirect_to operations_url, notice: 'Operation was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /operations/1
  def destroy
    @operation.destroy
    redirect_to operations_url, notice: 'Operation was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation
      @operation = Operation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def operation_params
      params.require(:operation).permit(:amount, :comment, :is_income, :date, :category_ids => [])
    end
end
