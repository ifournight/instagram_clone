require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = create_user({ name: 'ifournight', email: 'ifournight@gmail.com', encrypted_password: Devise::Encryptor.digest(User, 'codebone'), confirmed_at: Time.zone.now, sign_in_count: 0 })
  end
  
  test 'following relationship' do
    other = create_user
    @user.follow(other)

    assert @user.following.include?(other)
    assert other.followers.include?(@user)

    @user.unfollow(other)

    assert_not @user.following.include?(other)
    assert_not other.followers.include?(@user)
  end
end
