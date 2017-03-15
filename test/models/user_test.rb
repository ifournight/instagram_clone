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

  test 'user comment on post' do
    post = create_post

    comment = @user.comment_on(post, 'blabla')
    assert comment.valid?
    comment.save

    assert @user.reload.comments.include? comment
    assert post.reload.comments.include? comment
  end
end
