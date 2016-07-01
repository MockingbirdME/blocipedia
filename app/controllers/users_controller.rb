class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def user_to_standard
    @user = User.find(params[:user_id])
    @user.change_user_role(0)
    redirect_to :back
    flash[:notice] = "Membership level reset to standard"
  end

end
