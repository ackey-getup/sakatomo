class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @plays = @user.plays.order("created_at DESC")
  end
end