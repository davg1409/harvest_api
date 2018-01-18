class Api::V1::AttachmentsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :require_account!
  before_action :load_entry, only: [:index]

  def index
    @attachments = @entry.attachments
  end

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

    def load_entry
      @entry = @account.entries.find params[:entry_id]
    end
end 