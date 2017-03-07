# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/user_activate
  def user_activate
    @user = User.first
    @user.activation_token = User.new_token
    UserMailer.user_activate(@user, @user.activation_token)
  end

end
