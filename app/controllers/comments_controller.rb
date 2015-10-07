class CommentsController < ApplicationController
before_action :require_sign_in
  def create
    @post = Post.find(params[:post_id])
    @author = User.find(params[:author_id])
    @comment = @post.comments.build(comment_params)

    if @comment.save
      flash[:notice] = "Commented!"
      respond_to do |format|
        format.html { redirect_to @author }
        format.js
      end
    else
      @user = @author
      render 'users/show'
    end
  end

  def edit
    @post    = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_to @comment.author
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @comment.author }
      format.js
    end
  end

  private

    def comment_params
      params.permit(:author_id, :content)
    end
end
