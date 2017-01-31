class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  def show
  end

  def edit
  end

  def update
    if @user == current_user
      @user.update(user_params)
      redirect_to root_path, notice: 'you successfully updated user'
    else
      redirect_to new_user_session_path, alert: 'please edit again'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile, :position, :occupation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
