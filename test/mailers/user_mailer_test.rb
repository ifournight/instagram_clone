require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  # test "user_activate" do
  #   user = users(:ifournight)
  #   user.activation_token = User.new_token
  #   user.activation_digest = User.digest(user.activation_token)
  #   mail = UserMailer.user_activate(user,user.activation_token)
  #   assert_equal "#{user.name}, 欢迎使用 Instagram! 请验证你的邮箱", mail.subject
  #   assert_equal [user.email], mail.to
  #   assert_equal ["from@example.com"], mail.from

  #   token = extract_activation_token(mail.text_part.body.to_s)
  #   assert_not token.empty?
  #   assert user.authenticate(:activation, token)
  # end

end
