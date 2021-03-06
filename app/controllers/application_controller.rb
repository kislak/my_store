class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :danger, :error

  include ComfortableMexicanSofa.config.admin_auth.to_s.constantize
  include ComfortableMexicanSofa.config.admin_authorization.to_s.constantize
  before_action :authenticate
end
