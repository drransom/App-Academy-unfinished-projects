class PostsController < ApplicationController
  before_action :require_logged_in, except: [:show]
  def new
    @sub = Sub.find(params[:sub_id])
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to sub_url(@post.sub_id)
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_ids => [])
  end

  def require_logged_in
    unless current_user
      if params[:id]
        post = Post.find(params[:id])
        redirect_to post_url(post)
      else
        sub = Sub.find(params[:sub_id])
        redirect_to sub_url(sub)
      end
    end
  end
end
