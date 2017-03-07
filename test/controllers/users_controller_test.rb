require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  setup do
    @user = users(:ifournight)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "create exsit user should fail and redirect to signup" do
    assert_no_difference('User.count') do
      post users_url, params: { user: { email: @user.email, intro: @user.intro, name: @user.name, website: @user.website } }
    end

    assert_response :success
  end

  test "success create user should result sending welcom email" do
    perform_enqueued_jobs do
      post users_url, params:
                      {
                        user:
                        {
                          name: "uniquename_#{rand(1000)}",
                          email: "uniquemail_#{rand(1000)}@email.com",
                          password: 'password',
                          password_confirmation: 'password'
                        }
                      }
      user = User.last
      assert_redirected_to user
      follow_redirect!

      mail = ActionMailer::Base.deliveries.last
      assert_equal [user.email], mail.to

      # TODO Use RegExp to extract the token, and test use user's athenticate method
      text = mail.text_part.body.to_s
      activation_token = ''
      text.scan(URI.regexp) do |match|
        # match url
        match.each do |piece|
          # url piece
          next if piece.nil?
          piece.match(/^activation_token=(.*)/ix) do |token|
            activation_token = token[1]
          end
        end
      end
      assert_not activation_token.empty?
      assert user.authenticate(:activation, activation_token)
    end
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  # test "should update user" do
  #   patch user_url(@user), params: { user: { email: @user.email, intro: @user.intro, name: @user.name, website: @user.website } }
  #   assert_redirected_to user_url(@user)
  # end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end

  test "should activate user" do
    user = users(:ifournight)
    help_create_activation_digest(user)

    assert_not user.activated?

    get activate_user_url(user, activation_token: user.activation_token)

    assert user.reload.activated?
    assert_redirected_to user
  end

  test "should fail to activae user with wrong token" do
    user = users(:ifournight)
    help_create_activation_digest(user)
    user.save

    assert_not user.activated?

    get activate_user_url(user, activation_token: 'wrong token')

    assert_not user.reload.activated?
    assert_redirected_to users_url
  end
end
