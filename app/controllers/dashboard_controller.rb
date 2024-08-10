class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @boards = current_user.boards
    @recent_feedbacks = Feedback.order(created_at: :desc).limit(5)
    @top_voted_feedbacks = Feedback.order(cached_votes_score: :desc).limit(5)
  end
end
