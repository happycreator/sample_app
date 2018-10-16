class StaticPagesController < ApplicationController
  
  def home
    @user = User.find(session[:user_id])
  end

  def about
  end
end