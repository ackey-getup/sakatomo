class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @plays = @user.plays
  end
end
