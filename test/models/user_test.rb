require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @ifournight = users(:ifournight)
    @momo = users(:momo)
  end
  
  test 'following relationship' do
    @ifournight.follow(@momo)

    assert @ifournight.following.include?(@momo)
    assert @momo.followers.include?(@ifournight)

    @ifournight.unfollow(@momo)

    assert_not @ifournight.following.include?(@momo)
    assert_not @momo.followers.include?(@ifournight)
  end
end
