class PlayzonesController < ApplicationController
  before_action :authenticate_user!

  def index
    @plays = Play.all.order('created_at DESC')
  end
end
