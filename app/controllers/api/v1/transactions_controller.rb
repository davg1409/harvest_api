class Api::V1::TransactionsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :require_account!
  before_action :load_resource, except: [:index, :create]

  def index
    @transactions = @account.transactions
  end

  def create
    @transaction = @account.transactions.new transaction_params

    if @transaction.save
      render :show
    else
      render json: { errors: @transaction.errors.full_messages }, status: 422
    end
  end

  def update
    if @transaction.update transaction_params
      render :show
    else
      render json: { errors: @transaction.errors.full_messages }, status: 422
    end
  end

  def destroy
    if @transaction.destroy
      render :show
    else
      render json: { errors: "Not able to destroy chart account!!!" }, status: 422
    end
  end

  protected
    def load_resource
      @transaction = @account.transactions.find params[:id]
    end

    def transaction_params
      params.require(:transaction).permit(:date, :name, :note, :amount, :entry_type)
    end
end