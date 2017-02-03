class ProtosController < ApplicationController
  def new
    @proto = Proto.new
    num = 4
    @images = []
    num.times{ @images << @proto.images.build }
  end

  def create
    @proto = Proto.new(proto_params)
    if @proto.save
      redirect_to root_path, notice: 'you successfully created proto'
    else
      redirect_to new_proto_path, notice: 'create proto again'
    end
  end

  private
  def proto_params
    params.require(:proto).permit(
      :title,
      :catchcopy,
      :concept,
      images_attributes: [:id, :image, :role]
      ).merge(user_id: current_user.id)
  end
end
