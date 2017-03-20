require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include ActionView::Helpers::TextHelper

  def setup
    @user = create_user_without_confirmation
    sign_in @user
  end

  test '/:name path should get user page' do
    # generate follow actions
    10.times do
      other_user = create_user_without_confirmation
      @user.follow(other_user)
      other_user.follow(@user)
    end

    user_url = "#{root_url}#{@user.name}"
    get user_url

    # test user profile infos
    assert_select ".c-user-profile__avatar[src='#{gravatar_url_for(@user, size: 150)}']", 1
    assert_select '.c-user-profile__username', @user.name
    assert_select '.c-user-profile__info .c-user-profile__unit', "已发帖 #{@user.posts.count}", 1
    assert_select '.c-user-profile__info .c-user-profile__unit', "正在关注 #{@user.following.count}", 1
    assert_select '.c-user-profile__info .c-user-profile__unit', "#{@user.following.count} 人关注", 1
  end

  test "user page should have pagination for user's posts" do
    # generate 15 posts
    15.times do
      create_post(user_id: @user.id)
    end

    user_url = "#{root_url}#{@user.name}"
    get user_url

    posts = @user.posts.page(1).per(9)
    posts do |post|
      assert_match post.content, response.body.to_s
      assert_select "img[src='#{post.picture.middle.url}"
    end

    # posts count should match count per pagination
    assert_select '.c-post--users', 9

    # post count 15 larger than 9 (count per page), should display pagination btn
    assert_select '.pagination .c-btn'
  end

  # when a user has more than 9 (per pagination) counts posts , user page
  # should display 9 post at one time, and display a load more btn, and a success
  # ajax request should result posts of next page been added to page, and change
  # the state of load more btn right (either add a new load more btn or delete it.
  # )
  test "load more btn" do
    user_post_count = 50
    page_count = 2
    count_per_page = 9
    count_per_page_f = 9.0

    # generate posts
    user_post_count.times do
      create_post(user_id: @user.id)
    end

    user_url = "#{root_url}#{@user.name}"
    get user_url

    # send ajax request
    should_have_page = (user_post_count / 9.0).ceil

    should_have_page.times do
      get user_url, params: { page: page_count }, xhr: true
      assert_response :success
      assert_equal "text/javascript", @response.content_type
      posts = @user.posts.page(page_count).per(9)

      posts.each do |post|
        assert_match post.content, response.body
      end
      if page_count == should_have_page
        assert_match "html(\"\")", response.body.to_s
      end
      page_count += 1
    end
  end

  test "when a user has less than 9 posts, user page should display no pagination btn" do
    # generate 15 posts
    5.times do
      create_post(user_id: @user.id)
    end

    user_url = "#{root_url}#{@user.name}"
    get user_url

    posts = @user.posts.page(1).per(9)
    posts do |post|
      assert_match post.content, response.body.to_s
      assert_select "img[src='#{post.picture.middle.url}"
    end

    # if posts count less or equal than 9 (count per page)
    # expecting the post' count equal to 3 * (5 / 3.0).ceil
    assert_select '.c-post--users', 3 * (5 / 3.0).ceil

    # post count 15 larger than 9 (count per page), should display pagination btn
    assert_select '.pagination .c-btn', false
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
