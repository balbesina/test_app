class OperationsController < ApplicationController
  before_action :set_operation, only: [:edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :json, :js

  # GET /operations
  def index    
    @operations = Operation.where({:user_id => current_user.id}).order(date: :desc)
  end

  # POST /operations/filter
  def filter
    @operations = Operation.where({:user_id => current_user.id})
    @operations = @operations.where({:is_income => params[:is_income] == 'true'}) if params[:filter_by_type].present?
    @operations = @operations.where('date >= ?', DateTime.strptime(params[:date1], OperationsHelper::DTFormat)) if params[:filter_date1].present?
    @operations = @operations.where('date <= ?', DateTime.strptime(params[:date2], OperationsHelper::DTFormat)) if params[:filter_date2].present?
    if params[:category_ids].present?
        params[:category_ids].each do |category_id|
          @operations = @operations.joins(:categories).where(categories: {id: params[:category_ids]}).distinct
        end
    end
    @operations = @operations.order(date: :desc)
    render :index
  end

  # GET /operations/new
  def new
    @operation = Operation.new
    @operation.user_id = current_user.id
    @operation.id = 0
    @operation.is_income = true
    @operation.date = DateTime.now
  end

  def select_categories
    @categories = Category.where("user_id = ? AND is_income = ?", current_user.id, params[:is_income] == 'true')
    @operation = Operation.where("user_id = ? AND id = ?", current_user.id, params[:operation_id]).first
    respond_to do |format|
      format.js
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

    def filter_params
      params.permit(:filter_by_type,:is_income, :filter_date1, :date1, :filter_date2, :date2, :category_ids => [])
    end
end
