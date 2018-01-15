class Api::V1::EntriesController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :require_account!
  before_action :load_resource, except: [:index, :create]

  def index
    @entries = Search::EntrySearch.search params
  end

  def create
    @entry = @account.entries.new entry_params

    if @entry.save
      render :show
    else
      render json: { errors: @entry.errors.full_messages }, status: 422
    end
  end

  def update
    if @entry.update entry_params
      render :show
    else
      render json: { errors: @entry.errors.full_messages }, status: 422
    end
  end

  protected
    def load_resource
      @entry = @account.entries.find params[:id]      
    end

    def entry_params
      params[:entry][:entry_items_attributes] = params[:entry][:items] if params[:entry].present?
      params.require(:entry).permit(:date, :name, :note, :amount, :entry_type, tag_ids: [],   entry_items_attributes: [:amount, :dc, :chart_account_id, tag_ids: []])
    end
end 