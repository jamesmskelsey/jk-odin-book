class FriendshipsController < ApplicationController

  before_action :require_sign_in

  def index
    @friends = current_user.friendships.accepted
    @pending = current_user.friendships.pending
  end

  def create

    # find the requestor
    # find the requested friend
    # create a friendship connection with both people
    @user = User.find(params[:user_id])
    @friend = User.find(params[:id])

    unless @user == @friend
      # create a friendship with status 'requested' for the user
      request = @user.friendships.build(user_id: @user.id, friend_id: @friend.id, status: "requested")
      # create an opposite friendship with status 'pending' for the new friend
      pending = @friend.friendships.build(user_id: @friend.id, friend_id: @user.id, status: "pending")

        if pending.save && request.save
          flash[:notice] = "Friendship request sent!"
          redirect_to users_path
        else
          flash.now[:alert] = "The system doesn't think that friendship is a good idea. Classic Montagues."
          render 'users/index'
        end
      else
        flash[:alert] = "You can't be friends with yourself... at least not in public."
        redirect_to users_path
      end
  end

    def update
      # This doesn't read very well, but I'm grabbing both relationships to update them both.

      @request = get_friendship(params[:user_id], params[:friend_id])
      @pending = get_friendship(params[:friend_id], params[:user_id])

      @request.update(status: "accepted")
      @pending.update(status: "accepted")

      if @request.status == "accepted" && @pending.status == "accepted"
        flash[:notice] = "Great success!"
        redirect_to user_friendships_path
      else
        flash.now[:alert] = "Can not compute!"
        render 'index'
      end
    end

    # Destroying friendships... sounds lovely
    def destroy

      # this is actually kind of cool because I can cancel friend requests/deny requests/unfriend all with the same code
      @request = get_friendship(params[:user_id], params[:friend_id])
      @pending = get_friendship(params[:friend_id], params[:user_id])

      @request.destroy
      @pending.destroy

      redirect_to user_friendships_path
    end

    private

    def get_friendship(user_id, friend_id)
      Friendship.where("user_id = ? AND friend_id = ?", user_id, friend_id).first
    end
  end
