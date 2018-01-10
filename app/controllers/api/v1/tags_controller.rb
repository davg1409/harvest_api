class Api::V1::TagsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :load_resource, except: [:index, :create]

  def index
    @tags = Tag.all
  end

  def create
    @tag = Tag.new tag_params

    if @tag.save
      render :show
    else
      render json: { errors: @tag.errors.full_messages }, status: 422
    end
  end

  def update
    if @tag.update tag_params
      render :show
    else
      render json: { errors: @tag.errors.full_messages }, status: 422
    end
  end

  def destroy
    if @tag.destroy
      render :show
    else
      render json: { errors: "Not able to destroy Tag!!!" }, status: 422
    end
  end

  protected
    def load_resource
      @tag = Tag.find params[:id]
    end

    def tag_params
      params.require(:tag).permit(:name, :tag_kind_id)
    end
end