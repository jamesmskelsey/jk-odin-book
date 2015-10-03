class UsersController < ApplicationController

  # User actions new, create, edit, update, destroy are handled by devise
  # show and index will be the only two left to handle here.

  before_action :require_sign_in

  def index
    @users = User.all
  end

  def show
      @user = User.find(params[:id])
      @posts = @user.feed
      @post = Post.new
      # Bit of a hack since I don't seem to have access to the devise controller for creating new users.
      # Forces users to create a profile, and then if it gets deleted for some reason... it can be created.
      if current_user.profile.nil?
        redirect_to new_user_profiles_path(current_user)
      else
        @profile = @user.profile
      end
  end


end
