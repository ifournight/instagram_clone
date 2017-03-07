class UserMailer < ApplicationMailer

  def user_activate(user, activation_token)
    @user = user
    @athenticate_url = activate_user_url(@user, activation_token: activation_token)
    mail to: @user.email, subject: "#{@user.name}, 欢迎使用 Instagram! 请验证你的邮箱"
  end
end
