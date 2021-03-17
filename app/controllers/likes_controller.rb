class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(play_id: params[:play_id])
    redirect_back(fallback_location: current_path)
  end

  def destroy
    @like = Like.find_by(play_id: params[:play_id], user_id: current_user.id)
    @like.destroy
    redirect_back(fallback_location: current_path)
  end
end
