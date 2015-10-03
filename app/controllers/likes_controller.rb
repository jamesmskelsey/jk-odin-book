class LikesController < ApplicationController
before_action :require_sign_in
  def create
    @user = User.find_by(id: params[:user_id])
    @post = Post.find_by(id: params[:post_id])
    @post.likes.build(attributes: { user_id: @user.id }).save
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @post = Post.find_by(id: params[:post_id])
    @like = Like.where("user_id = ? AND likeable_id = ? AND likeable_type = ?", @user.id, @post.id, @post.class ).first
    @like.destroy
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end
end
