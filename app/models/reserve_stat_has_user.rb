class ReserveStatHasUser < ActiveRecord::Base
  belongs_to :user_reserve_stat
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => :user_reserve_stat_id
  validates_presence_of :user_reserve_stat_id, :user_id

  def self.per_page
    10
  end
end
