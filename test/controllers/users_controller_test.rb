require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = create_user_without_confirmation
    sign_in @user
  end

  test 'should follow' do
    other_user = create_user_without_confirmation
    other_user_url = "#{root_url}#{other_user.id}"

    get other_user_url
    assert @user.not_following?(other_user)
    assert_select ".button_to input[value='follow']"

    post follow_users_path(followed_id: other_user.id)
    assert_redirected_to other_user_url
    follow_redirect!

    assert_select ".button_to input[value='unfollow']"
    assert @user.reload.following?(other_user.reload)
  end

  test 'should unfollow' do
    other_user = create_user_without_confirmation
    other_user_url = "#{root_url}#{other_user.id}"

    @user.follow(other_user)
    get other_user_url
    assert @user.following?(other_user)
    assert_select ".button_to input[value='unfollow']"

    delete follow_users_path(followed_id: other_user.id)
    assert_redirected_to other_user_url
    follow_redirect!

    assert_select ".button_to input[value='follow']"
    assert @user.reload.not_following?(other_user.reload)
  end
end
