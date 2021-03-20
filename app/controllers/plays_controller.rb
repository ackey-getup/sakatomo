class PlaysController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :create, :edit, :update, :destroy]
  before_action :set_play, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :destroy]

  def index
    @plays = Play.all
  end

  def new
    @play = Play.new
  end

  def create
    @play = Play.new(play_params)
    if @play.save
      redirect_to list_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @play.comments.includes(:user)
  end

  def edit
  end

  def update
    if @play.update(play_params)
      redirect_to list_path
    else
      render :edit
    end
  end

  def destroy
    redirect_to list_path if @play.destroy
  end

  def help
  end

  def list
    @plays = Play.all.order('created_at DESC')
    @like = Like.new
  end

  private

  def play_params
    params.require(:play).permit(:title, :area_id, :place, :ground_style_id, :published_at, :detail,
                                 :image).merge(user_id: current_user.id)
  end

  def set_play
    @play = Play.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless current_user.id == @play.user_id
  end
end
