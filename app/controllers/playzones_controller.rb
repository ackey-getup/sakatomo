class PlayzonesController < ApplicationController
  def index
    @plays = Play.all.order("created_at DESC")
  end
end