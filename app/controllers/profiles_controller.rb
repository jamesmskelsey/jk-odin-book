class ProfilesController < ApplicationController

  def show

  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = params[:user_id]
    if @profile.save
      @user = @profile.user
      redirect_to @user
    else
      flash[:alert].now = "You must fill out your profile before continuing."
      render 'new'
    end
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile.update(profile_params)
    @user = User.find(params[:user_id])
    redirect_to @user
  end

  private

    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :hometown, :picture)
    end
end
