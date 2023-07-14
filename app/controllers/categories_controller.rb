class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = current_user.categories.includes(:transactions)
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      redirect_to categories_path, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @category = current_user.categories.find(params[:id])
    @category.destroy
    redirect_to categories_path, notice: 'Category was successfully deleted.'
  end

  def transactions
    @category = current_user.categories.find(params[:category_id])
    @transactions = @category.transactions.order(date: :desc)
    @total_amount = @transactions.sum(:amount)

    render :index, locals: { transactions: @transactions, total_amount: @total_amount }
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
