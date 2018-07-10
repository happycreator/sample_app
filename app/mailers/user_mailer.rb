class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "勤怠システム アカウントの有効化について"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "勤怠システム パスワードの再設定について"
  end
end