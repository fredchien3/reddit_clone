class UsersController < ApplicationController

  # def index # temporary
  #   render json: 'user index'
  # end

  def new
    # @user = User.new
    render :new
  end

  def create
    user = User.new(user_params)
    if user.save!
      log_in!(user)
      redirect_to subs_url
    else
      flash[:errors] = user.errors.full_messages
      render :new
    end
  end

  # def show
  # end

  # def edit
  # end

  # def update
  # end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end 
end