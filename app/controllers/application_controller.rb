class ApplicationController < ActionController::Base
  include Clearance::Controller
  include Pundit::Authorization
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
  def user_not_authorized
    flash[:error] = "Sorry, you don't have permission to do that"
    redirect_back(fallback_location: root_path)
  end
end
