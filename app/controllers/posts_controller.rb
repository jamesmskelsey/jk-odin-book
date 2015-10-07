class PostsController < ApplicationController
  before_action :correct_user, only: :destroy
  before_action :require_sign_in

  def show
    @post = Post.find(params[:id])
  end

  def create
    # this won't work for creating posts on other peoples pages... but that will require more code anyways to handle author/reciever
    @post = Post.new(post_params)
    @author = User.find(params[:post][:author_id])
    if @post.save
      flash.now[:notice] = "Post created."
      respond_to do |format|
        format.html { redirect_to user_path(@author) }
        format.js
      end
    else
      flash[:alert] = "Post must have content."
      @user = @author #change to post receiver during that implementation...
      render 'users/show'
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash.now[:notice] = "click click, post deleted"
    respond_to do |format|
      format.html { redirect_to request.referer || root_url }
      format.js
    end

  end

  def edit
    @edit = true
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  private

    def post_params
      params.require(:post).permit(:content, :author_id, :picture)
    end

    def correct_user
      # Sort of expecting something to go wrong here.
      @deletingpost = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @deletingpost.nil?
    end
end
