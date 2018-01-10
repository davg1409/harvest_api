class Api::V1::TagKindsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_resource, except: [:index, :create]

  def index
    @tag_kinds = TagKind.all
  end

  def create
    @tag_kind = TagKind.new tag_kind_params

    if @tag_kind.save
      render :show
    else
      render json: { errors: @tag_kind.errors.full_messages }, status: 422
    end
  end

  def update
    if @tag_kind.update tag_kind_params
      render :show
    else
      render json: { errors: @tag_kind.errors.full_messages }, status: 422
    end
  end

  def destroy
    if @tag_kind.destroy
      render :show
    else
      render json: { errors: "Not able to destroy Tag Kind!!!" }, status: 422
    end
  end

  protected
    def load_resource
      @tag_kind = TagKind.find params[:id]
    end

    def tag_kind_params
      params.require(:tag_kind).permit(:name)
    end
end