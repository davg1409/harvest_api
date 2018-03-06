class Api::V1::EntriesController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :require_account!
  before_action :load_resource, except: [:index, :create, :destroy_group]

  def index
    @entries = Search::EntrySearch.search @account, params
  end

  def create
    @entry = @account.entries.new entry_params
    
    if @entry.save
      Attachment.where(id: params[:entry][:attachments]).update_all(entry_id: @entry.id)
      render :show
    else
      render json: { errors: @entry.errors.full_messages }, status: 422
    end
  end

  def update
    if @entry.update entry_update_params
      @entry.update_attachments params[:entry][:attachments]
      @entry.reload
      render :show
    else
      render json: { errors: @entry.errors.full_messages }, status: 422
    end
  end

  def destroy
    if @entry.destroy
      render_success!
    else
      render json: { errors: @entry.errors.full_messages }, status: 422
    end 
  end

  def confirm
    if @entry.set_confirm! params[:confirm]
      render_success!
    else
      unprocessable_entity!
    end
  end

  def destroy_group
    if @account.entries.where(id: params[:entry_ids]).destroy_all
      render_success!
    else
      unprocessable_entity!
    end
  end

  protected
    def load_resource
      @entry = @account.entries.find params[:id]      
    end

    def entry_params
      params[:entry][:entry_items_attributes] = params[:entry][:items] if params[:entry].present?
      params.require(:entry).permit(:date, :date_end, :name, :note, :amount, :entry_type, tag_ids: [], customer_ids: [], vendor_ids: [], entry_items_attributes: [:amount, :dc, :chart_account_id, tag_ids: [], customer_ids: [], vendor_ids: []])
    end

    def entry_update_params
      params[:entry] ||= {}
      item_ids = @entry.entry_items.map(&:id)
      params[:entry][:items] ||= []
      param_item_ids = params[:entry][:items].map { |item| item[:id] }.compact

      item_ids.each do |item_id|
        if param_item_ids.exclude?(item_id.to_s)
          params[:entry][:items] << {id: item_id, _destroy: true}
        end
      end
      params[:entry][:entry_items_attributes] = params[:entry][:items] if params[:entry].present?
      params.require(:entry).permit(:date, :name, :note, :amount, :entry_type, tag_ids: [], customer_ids: [], vendor_ids: [], entry_items_attributes: [:id, :amount, :dc, :chart_account_id, :_destroy, tag_ids: [], customer_ids: [], vendor_ids: []])
    end
end 