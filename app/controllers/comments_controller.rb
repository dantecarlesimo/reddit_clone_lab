class CommentsController < ApplicationController
   
  before_filter :load_post

  def index
    @comments = @post.comments.all
  end

  def new
    @comment = @post.comments.new
  end

  def create
    comment = @post.comments.create comment_params
    comment[:user_id]=current_user.id
    comment.save

    redirect_to post_path(@post)
  end

  def show
    @comment = @post.comments.find(params[:id])
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    comment = Comment.find(params[:id])
    comment.update_attributes comment_params
    redirect_to(post.id)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to(post.id)
  end

  private
    def load_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:title)
    end
end
