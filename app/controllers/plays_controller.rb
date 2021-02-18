class PlaysController < ApplicationController

  def index
  end

  def new
    @play = Play.new
  end

  def create
    @play = Play.new(play_params)
    if @play.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def play_params
    params.require(:play).permit(:title, :place, :ground_style_id, :published_at, :detail, :image).merge(user_id: current_user.id)
  end
end