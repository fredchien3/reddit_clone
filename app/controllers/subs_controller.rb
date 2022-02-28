class SubsController < ApplicationController

  def index
    @subs = Sub.all
    render :index
  end
    
  def 
end