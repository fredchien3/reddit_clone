class SubsController < ApplicationController
  before_action :require_logged_in, only: [:new, :create]
  def index
    @subs = Sub.all
    render :index
  end

  def new
    render :new
  end

  def create
    sub = Sub.new(sub_params)
    sub.user_id = current_user.id
    if sub.save!
      redirect_to sub_url(sub), notice: "Sub created successfully!"
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def edit
    @sub = Sub.find(params[:id])
    if @sub.moderator != current_user
      redirect_to sub_url(@sub), notice: "Only the sub moderator can edit the sub!"
    else
      render :edit
    end
    
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub), notice: "Edit successful!"
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    if @sub.moderator != current_user
      redirect_to sub_url(@sub), notice: "Only the sub moderator can delete the sub!"
    else
      @sub.destroy!
      redirect_to subs_url
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end