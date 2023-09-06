class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: params[:user_id])
  end

  def show
    # @user = User.find_by(id: params[:user_id])
    @post = Post.where(author_id: params[:user_id], id: params[:id]).first
    # @current_user = current_user
    @like = Like.new
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.post.new(post_param)
    if @post.save
      redirect_to user_post_path(current_user, @post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_param
    params.require(:post).permit(:title, :text)
  end
end
