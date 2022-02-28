class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if user.nil?
      render json: "username or password were incorrect"
    else
      log_in!(user)
      redirect_to users_url
    end
  end

  def destroy
    log_out!
    redirect_to subs_url
  end
end