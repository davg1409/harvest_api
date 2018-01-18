class Api::V1::AttachmentsController < ApplicationController
  before_action :authenticate_api_v1_user!

  def create
    @attachment = Attachment.new attachment_params

    if @attachment.save
      render :show
    else
      render json: {
        success: false,
        errors: @attachment.errors.full_messages
      }, status: 422
    end
  end

  protected
    def attachment_params
      params.require(:attachment).permit(:filename, :document, {})
    end
end 