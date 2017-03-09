require 'test_helper'

class FollowActionTest < ActiveSupport::TestCase
  test 'follow_action have followed and follower id' do
    follow_action = FollowAction.new
    assert follow_action.invalid?

    assert_match /blank/, follow_action.errors[:follower_id].join
    assert_match /blank/, follow_action.errors[:followed_id].join
  end
end
