class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like

  def create
      user = current_user
      play = Play.find(params[:play_id])
      like = Like.create(user_id: user.id, play_id: play.id)
  end
  def destroy
      user = current_user
      play = play.find(params[:play_id])
      like = Like.find_by(user_id: user.id, play_id: play.id)
      like.delete
  end

  private
  def set_like
      @play = play.find(params[:play_id])
  end
end
