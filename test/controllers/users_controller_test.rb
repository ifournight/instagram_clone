require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include ActionView::Helpers::TextHelper
  def setup
    @user = create_user_without_confirmation
    sign_in @user
  end

  test '/:name path should get user page' do
    user_url = "#{root_url}#{@user.name}"
    get user_url

    assert_select "img.gravatar[src='#{gravatar_url_for(@user)}']"
    assert_select 'p', 'following 0 people', 1
    assert_select 'p', '0 followers', 1
    assert_select '.button_to', false

    10.times do
      other_user = create_user_without_confirmation
      @user.follow(other_user)
      other_user.follow(@user)
    end

    get user_url
    assert_select 'p', "following #{pluralize(@user.following.count, 'people')}", 1
    assert_select 'p', pluralize(@user.followers.count, 'follower'), 1
  end

  test 'should follow' do
    other_user = create_user_without_confirmation
    other_user_url = "#{root_url}#{other_user.name}"

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
    other_user_url = "#{root_url}#{other_user.name}"

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
