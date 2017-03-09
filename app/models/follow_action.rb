class FollowAction < ApplicationRecord
  # RELATIONS
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  # VALIDATES
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
