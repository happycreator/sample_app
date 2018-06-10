class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "アカウントは有効化されていません。 "
        message += "Emailを確認してアカウントの有効化をクリックしてください。"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Emailまたはパスワードが間違っています。'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end