class PlayzonesController < ApplicationController
  def index
    @plays = Play.all
  end
end