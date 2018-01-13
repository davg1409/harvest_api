class Search::EntrySearch
  attr_accessor :is_confirmed, :chart_account_id, :end_date, :start_date, :tag_ids

  # class methods
  class << self
    def search params = {}
      self.new(params).search
    end
  end

  # instance methods
  def initialize params = {}

    if params[:status].present?
      @is_confirmed = params[:status] == "complete"  
    end

    @chart_account_id = params[:chart_account_id]

    @end_date = Date.strptime(params[:end_date], "%y-%m-%d") - 1.day rescue nil if params[:end_date].present?
    @start_date = Date.strptime(params[:start_date], "%y-%m-%d") rescue nil if params[:start_date].present?

    @tag_ids = params[:tags] || []
    @tag_ids = [] if !@tag_ids.is_a?(Array)
  end

  def search
    Entry.search do
      with :is_confirmed, is_confirmed if !is_confirmed.nil?
      with(:date).less_than_or_equal_to end_date if end_date.present?
      with(:date).greater_than start_date if start_date.present?
      with :chart_account_id, chart_account_id if chart_account_id.present?

      if tag_ids.present?
        any_of do
          with :tag_ids, tag_ids
        end
      end
    end.results
  end
end