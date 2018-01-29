class Search::EntrySearch
  attr_accessor :is_confirmed, :chart_account_id, :end_date, :start_date, :tag_ids, :account, :direction

  # class methods
  class << self
    def search account, params = {}
      self.new(account, params).search
    end
  end

  # instance methods
  def initialize account, params = {}
    @account = account

    if params[:status].present?
      @is_confirmed = params[:status] == "complete"  
    end

    @chart_account_id = params[:chart_account_id]

    @end_date = Date.strptime(params[:end_date], "%Y-%m-%d") rescue nil if params[:end_date].present?
    @start_date = Date.strptime(params[:start_date], "%Y-%m-%d") rescue nil if params[:start_date].present?

    @tag_ids = params[:tags] || []
    @tag_ids = [] if !@tag_ids.is_a?(Array)
    @sort = params[:sort] || "date"

    @direction = params[:direction] == 'asc' ? params[:direction] : "desc"
  end

  def sort
    case @sort
    when  "amount", "name"
      @sort
    else
      @sort = "date"      
    end
  end

  def search
    results = account.entries.joins(:entry_items)
    results = results.where(is_confirmed: is_confirmed) if !is_confirmed.nil?
    results = results.where("date <= ? ", end_date) if end_date.present?
    results = results.where("date >= ? ", start_date) if start_date.present?
    results = results.where("entry_items.chart_account_id = ?", chart_account_id) if chart_account_id.present?

    results = results.joins({entry_tags: :tag}, entry_items: {entry_item_tags: :tag}).where("tags.id IN (?)", tag_ids) if tag_ids.present?
  
    results = account.entries.where(id: results.map(&:id)).includes(:entry_items, :attachments, :tags)
    results.order("#{sort} #{direction}")
  end
end