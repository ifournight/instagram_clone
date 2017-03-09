class User < ApplicationRecord
  # RELATIONS
  has_many :active_follow_actions,
              class_name: 'FollowAction',
              foreign_key: 'follower_id',
              dependent: :destroy
  has_many :passive_follow_actions,
              class_name: 'FollowAction',
              foreign_key: 'followed_id',
              dependent: :destroy
  has_many :following, through: :active_follow_actions,
                       source: :followed
  has_many :followers, through: :passive_follow_actions,
                       source: :follower

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Follow a user
  def follow(other_user)
    following << other_user
  end

  # Unfollow a user
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Return true if current user is following the other user
  def following?(other_user)
    following.include?(other_user)
  end

  def not_following?(other_user)
    !following?(other_user)
  end
end
