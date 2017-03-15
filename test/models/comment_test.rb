require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'comment content must not be blank' do
    comment = Comment.new
    assert comment.invalid?
    assert_match(/blank/, comment.errors[:content].join)
  end
end
