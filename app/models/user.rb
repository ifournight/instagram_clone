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
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy


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

  def post_feeds
    following_ids = "SELECT followed_id FROM follow_actions
                        WHERE  follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
                        OR user_id = :user_id", user_id: id)
  end

  class CommentOnInvalidPostError < StandardError
  end
  
  def comment_on(post, content)
    throw CommentOnInvalidPostError.new if post.invalid?
    throw CommentOnInvalidPostError.new unless post.persisted?

    comment = comments.build(content: content, post_id: post.id, user_id: id)
  end
end
