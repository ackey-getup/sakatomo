class PlaysController < ApplicationController
  before_action :set_play, only: [:show, :edit]

  def index
    @plays = Play.all
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

  def show
  end

  def edit
  end

  def update
    if @play.update(play_params)
      redirect_to play_path(plays_path)
    else
      render :edit
    end
  end

  def destroy
    @play.destroy
    redirect_to root_path
  end

  private
  def play_params
    params.require(:play).permit(:title, :area_id, :place, :ground_style_id, :published_at, :detail, :image).merge(user_id: current_user.id)
  end

  def set_play
    @play = Play.find(params[:id])
  end
end