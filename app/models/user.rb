class User < ApplicationRecord
  # RELATIONS

  # VALIDATIONS
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

  # HOOKS
  before_create :create_activation_digest

  # ATTRIBUTES
  attr_accessor :activation_token

  # METHODS CLASS -> INSTANCE
  # Returns the hash digest of the given string.
  def self.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
  end

  # Generate a token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  # Generalized autheticate method:
  # It assumes this patterm:
  # user:
  #   :key_token
  #   :key_digest
  # and caller supply the key name and the token and this method will verify it.
  def authenticate(key, token)
    digest_key = send("#{key.to_s.downcase}_digest")
    return false if digest_key.nil?
    BCrypt::Password.new(digest_key).is_password?(token)
  end

  private

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
