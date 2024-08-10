class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_feedback

  def create
    @comment = @feedback.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to board_feedback_path(@feedback.board, @feedback), notice: 'Comment was successfully added.'
    else
      redirect_to board_feedback_path(@feedback.board, @feedback), alert: 'Error adding comment.'
    end
  end

  def destroy
    @comment = @feedback.comments.find(params[:id])
    @comment.destroy
    redirect_to board_feedback_path(@feedback.board, @feedback), notice: 'Comment was successfully removed.'
  end

  private

  def set_feedback
    @feedback = Feedback.find(params[:feedback_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end