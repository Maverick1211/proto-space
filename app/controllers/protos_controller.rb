class ProtosController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @protos = Proto.includes(:images).all
  end

  def new
    @proto = Proto.new
    @proto.images << Image.new(role: :main)
    3.times do
      @proto.images << Image.new(role: :sub)
    end
  end

  def create
    @proto = current_user.protos.new(proto_params)
    if @proto.save
      redirect_to root_path, notice: 'you successfully created proto'
    else
      render 'new'
      flash[:notice] = 'create proto again'
    end
  end

  private

  def proto_params
    params.require(:proto).permit(
      :title,
      :catchcopy,
      :concept,
      images_attributes: [:id, :image, :role]
      )
  end
end
