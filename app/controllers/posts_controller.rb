class PostsController < ApplicationController
  before_action :require_logged_in, only: [:new, :create]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.sub_id = 0
    @post.sub_ids = post_params[:sub_ids]

    if @post.save!
      redirect_to post_url(@post), notice: "Post created successfully!"
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def edit
    @post = Post.find(params[:id])
    if @post.author != current_user
      redirect_to post_url(@post), notice: "Only the post author can edit the post!"
    else
      render :edit
    end
    
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post), notice: "Edit successful!"
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Sub.find(params[:id])
    if @post.author != current_user
      redirect_to post_url(@post), notice: "Only the post author can delete the post!"
    else
      @post.destroy!
      redirect_to posts_url
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :url, :content, :sub_id, sub_ids: [])
  end
end