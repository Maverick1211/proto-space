class Protos::PopularController < ApplicationController
  def index
    @protos = Proto.includes(:images).order('likes_count DESC')
  end
end
