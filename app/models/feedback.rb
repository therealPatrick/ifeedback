class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :board
  has_many :comments
  acts_as_votable
end
