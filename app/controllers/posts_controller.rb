class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      @post.create_image(image_params)
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    @post.destroy
    redirect_to request.referrer || root_url
  end

  private

  def post_params
    params.require(:post).permit(:title)
  end

  def image_params
    params.require(:post).permit(:file)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end

end
