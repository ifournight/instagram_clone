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

    10.times do
      other_user = create_user_without_confirmation
      @user.follow(other_user)
      other_user.follow(@user)
    end

    get user_url

    assert_select ".c-user-profile__avatar[src='#{gravatar_url_for(@user, size: 150)}']", 1
    assert_select '.c-user-profile__username', @user.name
    assert_select '.c-user-profile__info .c-user-profile__unit', "已发帖 #{@user.posts.count}", 1
    assert_select '.c-user-profile__info .c-user-profile__unit', "正在关注 #{@user.following.count}", 1
    assert_select '.c-user-profile__info .c-user-profile__unit', "#{@user.following.count} 人关注", 1

    @user.posts.each do |post|
      assert_match post.content, response.body.to_s
      assert_select "img[src='#{post.picture.middle.url}"
    end
  end

  # test 'should follow' do
  #   other_user = create_user_without_confirmation
  #   other_user_url = "#{root_url}#{other_user.name}"

  #   get other_user_url
  #   assert @user.not_following?(other_user)
  #   assert_select ".button_to input[value='follow']"

  #   post follow_users_path(followed_id: other_user.id)
  #   assert_redirected_to other_user_url
  #   follow_redirect!

  #   assert_select ".button_to input[value='unfollow']"
  #   assert @user.reload.following?(other_user.reload)
  # end

  # test 'should unfollow' do
  #   other_user = create_user_without_confirmation
  #   other_user_url = "#{root_url}#{other_user.name}"

  #   @user.follow(other_user)
  #   get other_user_url
  #   assert @user.following?(other_user)
  #   assert_select ".button_to input[value='unfollow']"

  #   delete follow_users_path(followed_id: other_user.id)
  #   assert_redirected_to other_user_url
  #   follow_redirect!

  #   assert_select ".button_to input[value='follow']"
  #   assert @user.reload.not_following?(other_user.reload)
  # end

  # test 'should like' do
  #   other_user = create_user_without_confirmation
  #   @user.follow(other_user)
  #   post = create_post(user_id: other_user.id)
  #   get root_url
  #   assert_equal LikeAction.count, 0
  #   assert_not @user.like?(post)

  #   assert_difference 'LikeAction.count', 1 do
  #     post like_user_path(id: @user.id, post_id: post.id)
  #   end

  #   assert @user.like?(post)
  # end

  test 'should fail when provide empty current password when change password' do
    get new_account_password_change_path(@user)
    post account_password_change_path(
      params: {
        id: @user.id,
        user: {
          current_password: '',
          password: '12345678',
          password_confirmation: '12345678'
        }
      }
    )

    assert @user.reload.valid_password?('password')

    user = assigns(:user)
    assert_match(/blank/, user.errors[:current_password].join)
    assert_template :password_change_new
  end

  test "should fail when password and confirmation doesn't match while changing password" do
    get new_account_password_change_path(@user)
    post account_password_change_path(
      params: {
        id: @user.id,
        user: {
          current_password: 'password',
          password: '12345678',
          password_confirmation: '1234567890'
        }
      }
    )

    assert @user.reload.valid_password?('password')

    user = assigns(:user)
    assert_match(/match/, user.errors[:password_confirmation].join)
    assert_template :password_change_new
  end

  test 'should change password with valid params' do
    get new_account_password_change_path(@user)

    post account_password_change_path(
      params: {
        id: @user.id,
        user: {
          current_password: 'password',
          password: '12345678',
          password_confirmation: '12345678'
        }
      }
    )

    assert @user.reload.valid_password?('12345678')

    user = assigns(:user)

    assert_not user.errors.any?
  end
end
