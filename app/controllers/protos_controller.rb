class ProtosController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @protos = Proto.includes(:images).all
  end

  def new
    @proto = Proto.new
  end

  def create
    @proto = current_user.protos.new(proto_params)
    if @proto.save
      redirect_to root_path, notice: 'you successfully created proto'
    else
      @proto = Proto.new
      @proto.assign_attributes(proto_params.except(:images_attributes))
      flash.now[:notice] = 'create proto again'
      render action: :new
    end
  end

  def show
    @proto = Proto.find(params[:id])
    @comment = @proto.comments.build
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
