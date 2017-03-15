class Comment < ApplicationRecord
  # RELATIONS
  belongs_to :post
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

  # QUERYS
  default_scope -> { order(created_at: :desc) }

  # VALIDATIONS
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :content, presence: true,
                      length: 0..200

end
