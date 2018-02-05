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
      @is_confirmed = params[:status].to_s.downcase == "complete"
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
    
    if tag_ids.present?
      results = results.joins("LEFT JOIN entry_tags ON entry_tags.entry_id = entries.id LEFT JOIN tags ON tags.id = entry_tags.tag_id")
                        .joins("LEFT JOIN entry_item_tags ON entry_item_tags.entry_item_id = entry_items.id LEFT JOIN tags i_tags ON i_tags.id = entry_item_tags.tag_id")    
      results = results.where("tags.id IN (?) or i_tags.id IN (?)", tag_ids, tag_ids)
    end
    account.entries.where(id: results.map(&:id)).includes(:entry_items, :attachments, :tags).order("#{sort} #{direction}")
  end
end