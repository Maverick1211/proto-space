class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.js { @comment }
      else
        flash.now[:alert] = "please comment again"
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, proto_id: params[:proto_id])
  end
end
