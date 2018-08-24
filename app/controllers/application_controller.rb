# frozen_string_literal: true
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do
    redirect_to root_url
  end

  def after_sign_in_path_for(_resource)
    session[:previous_url] || forecasts_path
  end

  def handle_unverified_request
    redirect_to root_url
  end
end
