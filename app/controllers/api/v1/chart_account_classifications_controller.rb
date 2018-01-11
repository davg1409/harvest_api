class Api::V1::ChartAccountClassificationsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :load_resource, except: [:index, :create]

  def index
    @cacs = ChartAccountClassification.all
  end

  def create
    @cac = ChartAccountClassification.new cac_params

    if @cac.save
      render :show
    else
      render json: { errors: @cac.errors.full_messages }, status: 422
    end
  end

  def update
    if @cac.update cac_params
      render :show
    else
      render json: { errors: @cac.errors.full_messages }, status: 422
    end
  end

  def destroy
    if @cac.destroy
      render :show
    else
      render json: { errors: "Not able to destroy chart account classification!!!" }, status: 422
    end
  end

  protected
    def load_resource
      @cac = ChartAccountClassification.find params[:id]
    end

    def cac_params
      params.require(:chart_account_classification).permit(:name)
    end
end