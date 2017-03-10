class Post < ApplicationRecord
  # RELATIONS
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

  # QUERYs
  default_scope -> { order(created_at: :desc) }

  # VALIDATIONS
  validates :user_id, presence: true
end
