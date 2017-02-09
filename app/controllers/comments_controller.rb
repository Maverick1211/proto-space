class CommentsController < ApplicationController
  before_action :set_proto, only: :create
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
    params.require(:comment).permit(:text).merge(user_id: @proto.user_id, proto_id: @proto.id)
    # 複数の項目を足すのでmergeにしました
  end

  def set_proto
    @proto = Proto.find(params[:proto_id])
  end
end
