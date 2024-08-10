class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :board
  has_many :comments
  acts_as_votable
  
  # pagination feature
  scope :sort_by_votes, -> { order(votes_count: :desc) }
  scope :sort_by_date, -> { order(created_at: :desc) }
  scope :filter_by_status, ->(status) { where(status: status) if status.present? }
  scope :filter_by_category, ->(category) { where(category: category) if category.present? }
end
