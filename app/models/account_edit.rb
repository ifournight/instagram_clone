class AccountEdit
  include ActiveModel::Model

  attr_accessor(
    :name,
    :email,
    :user
  )

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true
  validates :email, presence: true
  validates :email, format: {
    with:  VALID_EMAIL_REGEX,
    message: "invalid email address."
  }

  # validate :different_email_from_current

  def edit
    if valid?
      @user.update_attributes(name: self.name, email: self.email)
      @user.save
    end
  end

  private

  def different_email_from_current
    if email == @user.email
      errors.add(:email, "must be different from current one.")
    end
  end
end
