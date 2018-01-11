class Api::V1::ChartAccountsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :require_account!
  before_action :load_resource, except: [:index, :create]

  def index
    @chart_accounts = @account.chart_accounts
  end

  def create
    @chart_account = @account.chart_accounts.new chart_account_params

    if @chart_account.save
      render :show
    else
      render json: { errors: @chart_account.errors.full_messages }, status: 422
    end
  end

  def update
    if @chart_account.update chart_account_params
      render :show
    else
      render json: { errors: @chart_account.errors.full_messages }, status: 422
    end
  end

  def destroy
    if @chart_account.destroy
      render :show
    else
      render json: { errors: "Not able to destroy chart account!!!" }, status: 422
    end
  end

  protected
    def load_resource
      @chart_account = @account.chart_accounts.find params[:id]
    end

    def chart_account_params
      params.require(:chart_account).permit(:name, :parent_id)
    end
end