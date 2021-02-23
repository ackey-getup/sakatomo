class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:image, :nickname, :profile, :position_id, :play_style_id, :play_experience_id, :main_play_area_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:image, :nickname, :profile, :position_id, :play_style_id, :play_experience_id, :main_play_area_id])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end