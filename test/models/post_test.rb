require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'post must have user_id' do
    post = new_post
    assert post.invalid?
    assert_match(/blank/, post.errors[:user_id].join)
  end

  test 'post fetched from database should be sorted decrementally based on creation date' do
    10.times do
      new_post
    end

    posts = Post.first(10)

    posts.each.with_index do |post, index|
      if index != posts.count - 1
        assert post.created_at > posts[index + 1].created_at
      end
    end
  end

  test "post picture can't be blank" do
    post = Post.new(content: 'blabla')
    assert post.invalid?

    assert_match(/blank/, post.errors[:picture].join)
  end
end
