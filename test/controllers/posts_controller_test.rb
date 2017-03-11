require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = create_user_without_confirmation
    sign_in @user
  end

  test 'should get create' do
    assert_difference 'Post.count' do
      picture = generate_picture
      post user_posts_path(@user), params:
      {
        post: { content: 'content', picture: picture }
      }
    end

    assert_redirected_to root_url
  end
end
