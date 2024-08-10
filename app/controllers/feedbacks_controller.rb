class FeedbacksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board
  before_action :set_feedback, only: [:show, :edit, :update, :destroy, :upvote, :downvote]

  def index
    @feedbacks = @board.feedbacks

    @feedbacks = Feedback.all
    @feedbacks = @feedbacks.sort_by_votes if params[:sort] == 'votes'
    @feedbacks = @feedbacks.sort_by_date if params[:sort] == 'date'
    @feedbacks = @feedbacks.filter_by_status(params[:status])
    @feedbacks = @feedbacks.filter_by_category(params[:category])
    @feedbacks = @feedbacks.page(params[:page]).per(10) # Assuming 10 items per page
  end

  def show
  end

  def new
    @feedback = @board.feedbacks.new
  end

  def create
    @feedback = @board.feedbacks.new(feedback_params)
    @feedback.user = current_user
    if @feedback.save
      redirect_to board_feedback_path(@board, @feedback), notice: 'Feedback was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @feedback.update(feedback_params)
      redirect_to board_feedback_path(@board, @feedback), notice: 'Feedback was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @feedback.destroy
    redirect_to board_feedbacks_path(@board), notice: 'Feedback was successfully destroyed.'
  end

  def upvote
    @feedback.upvote_by current_user
    redirect_to board_feedback_path(@board, @feedback)
  end

  def downvote
    @feedback.downvote_by current_user
    redirect_to board_feedback_path(@board, @feedback)
  end

  private

  def set_board
    @board = Board.find(params[:board_id])
    if @board.nil?
      redirect_to board_path, alert: "Board not found"
    end
  end

  def set_feedback
    @feedback = @board.feedbacks.find(params[:id])
  end

  def feedback_params
    params.require(:feedback).permit(:title, :description, :status)
  end
end