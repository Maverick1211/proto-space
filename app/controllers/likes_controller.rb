class LikesController < ApplicationController
  before_action :total_likes, :set_proto, only: %i(create destroy)

  def create
    Like.create(user_id: current_user.id, proto_id: params[:proto_id])
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
  end

  private

  def total_likes
    @likes = Like.where(proto_id: params[:proto_id])
  end

  def set_proto
    @proto = Proto.find(params[:proto_id])
  end
end
