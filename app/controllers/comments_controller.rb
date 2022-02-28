class CommentsController < ApplicationController
  before_action :require_logged_in

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    render :new
  end

  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save!
      redirect_to post_url(@post), notice: "Comment created successfully!"
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  # def show
  #   @comment = Comment.find(params[:id])
  #   render :show
  # end

  # def edit
  #   @comment = Comment.find(params[:id])
  #   if @comment.author != current_user
  #     redirect_to subs_url, notice: "Only the comment author can edit the comment!"
  #   else
  #     render :edit
  #   end
  # end

  # def update
  #   @comment = Comment.find(params[:id])
  #   if @comment.update_attributes(comment_params)
  #     redirect_to comment_url(@comment), notice: "Edit successful!"
  #   else
  #     flash.now[:errors] = @comment.errors.full_messages
  #     render :edit
  #   end
  # end

  # def destroy
  #   @comment = Sub.find(params[:id])
  #   if @comment.author != current_user
  #     redirect_to comment_url(@comment), notice: "Only the comment author can delete the comment!"
  #   else
  #     @comment.destroy!
  #     redirect_to comments_url
  #   end
  # end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end