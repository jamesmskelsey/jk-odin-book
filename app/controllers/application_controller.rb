class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
include FriendshipsHelper
  def require_sign_in
    unless user_signed_in?
      flash[:alert] = "You must sign in to do that."
      redirect_to user_session_path
    end
  end
end
