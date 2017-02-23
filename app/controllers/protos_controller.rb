class ProtosController < ApplicationController
  before_action :authenticate_user!, except: %i(index show)
  before_action :set_proto, only: %i(show edit update destroy)

  def index
    case params[:sortby]
      when "newly"
        @protos = Proto.includes(:images).newly
      else
        @protos = Proto.includes(:images).popular
    end
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
    @comment = Comment.new
  end

  def edit; end

  def update
    if @proto.update(proto_params)
      redirect_to root_path, notice: 'you successfully updated proto'
    else
      @proto = Proto.find(params[:id])
      @proto.assign_attributes(proto_params.except(:images_attributes))
      flash.now[:alert] = 'please edit again'
      render action: :edit
    end
  end

  def destroy
    if @proto.destroy
      redirect_to root_path, notice: 'you successfully delete protos'
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

  def set_proto
    @proto = Proto.find(params[:id])
  end
end
