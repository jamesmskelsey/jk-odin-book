class UsersController < ApplicationController

  # User actions new, create, edit, update, destroy are handled by devise
  # show and index will be the only two left to handle here.

  before_action :require_sign_in

  def index
    @users = User.all
  end

  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  
end
