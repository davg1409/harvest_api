class Api::V1::EntriesController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :require_account!

  def create
    @entry = @account.entries.new entry_params

    if @entry.save
      render :show
    else
      render json: { errors: @entry.errors.full_messages }, status: 422
    end
  end

  protected
    def entry_params
      params[:entry][:entry_items_attributes] = params[:entry][:items] if params[:entry].present?
      params.require(:entry).permit(:date, :name, :note, :amount, :entry_type, tag_ids: [],   entry_items_attributes: [:amount, :dc, :chart_account_id, tag_ids: []])
    end
end 