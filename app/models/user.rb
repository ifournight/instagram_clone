class User < ApplicationRecord
  # Relations

  # Validations
  validates :name, presence: true,
                   uniqueness: { message: "Hey, %{model} %{attribute} '%{value}' is already been taken!" }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX},
                    length: { maximum: 150 },
                    uniqueness: { message: "Hey, %{attribute} '%{value}' is already been taken!" }
  validates :password, :password_confirmation, presence: true,
                                               length: { minimum: 8 }

  has_secure_password

  # Returns the hash digest of the given string.
  def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
  end
end
