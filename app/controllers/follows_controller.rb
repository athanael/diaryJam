class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    if current_user.following?(@user)
      flash[:alert] = "Vous suivez déjà #{@user.username}."
    else
      current_user.favorite(@user)
      flash[:notice] = "Vous suivez maintenant #{@user.username}."
    end
    redirect_to user_path(@user)
  end

  def destroy
    if current_user.following?(@user)
      current_user.unfavorite(@user)
      flash[:notice] = "Vous ne suivez plus #{@user.username}."
    else
      flash[:alert] = "Vous ne suivez pas cet utilisateur."
    end
    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
