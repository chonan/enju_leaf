class BookmarkStat < ActiveRecord::Base
  include AASM
  include CalculateStat
  scope :not_calculated, :conditions => {:state => 'pending'}
  has_many :bookmark_stat_has_manifestations
  has_many :manifestations, :through => :bookmark_stat_has_manifestations

  validates_presence_of :start_date, :end_date
  validate :check_date

  aasm_column :state
  aasm_state :pending
  aasm_state :completed

  aasm_initial_state :pending

  aasm_event :aasm_calculate do
    transitions :from => :pending, :to => :completed,
      :on_transition => :calculate_count
  end

  def self.per_page
    10
  end

  def check_date
    if self.start_date and self.end_date
      if self.start_date >= self.end_date
        errors.add(:start_date)
        errors.add(:end_date)
      end
    end
  end

  def calculate_count
    self.started_at = Time.zone.now
    Resource.find_each do |manifestation|
      daily_count = Bookmark.manifestations_count(self.start_date, self.end_date, manifestation)
      #manifestation.update_attributes({:daily_bookmarks_count => daily_count, :total_count => manifestation.total_count + daily_count})
      if daily_count > 0
        self.manifestations << manifestation
        sql = ['UPDATE bookmark_stat_has_manifestations SET bookmarks_count = ? WHERE bookmark_stat_id = ? AND manifestation_id = ?', daily_count, self.id, manifestation.id]
        ActiveRecord::Base.connection.execute(
          self.class.send(:sanitize_sql_array, sql)
        )
      end
    end
    self.completed_at = Time.zone.now
  end
end
