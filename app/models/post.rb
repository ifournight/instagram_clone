class Post < ApplicationRecord
  # RELATIONS
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  has_many :comments
  has_many :likes, class_name: 'LikeAction', foreign_key: 'post_id'


  # QUERYs
  default_scope -> { order(created_at: :desc) }

  # VALIDATIONS
  validates :user_id, presence: true
  validates :picture, presence: true
  validate  :picture_size

  mount_uploader :picture, PostPictureUploader

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, 'should be less than 5MB')
    end
  end
end
