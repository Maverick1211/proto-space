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
      flash.now[:alert] = 'create proto again'
      render action: :new
    end
  end

  def show
    @proto = Proto.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @proto = Proto.find(params[:id])
  end

  def update
    @proto = Proto.find(params[:id])
    if @proto.update
      redirect_to root_path
    else
      redirect_to edit_proto_path(@proto), notice: 'please edit agein'
    end
  end

  def destroy
    @proto = Proto.find(params[:id])
    if @proto.destroy
      redirect_to root_path
    else
      redirect_to root_path, alert: 'please delete agein'
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
