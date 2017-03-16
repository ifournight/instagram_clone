class LikeAction < ApplicationRecord
  # RELATIONS
  belongs_to :user
  belongs_to :post

  # VALIDATIONS
  validates :user_id, presence: true
  validates :post_id, presence: true
end
