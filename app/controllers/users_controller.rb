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
  end


end
