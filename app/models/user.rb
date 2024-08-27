class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, if: -> { password.present? }

  validate :passwords_match

  def self.authenticate_with_credentials(email, password)
    # Normalize the email (e.g., downcase)
    normalized_email = email.strip.downcase
    # Find the user by normalized email
    user = User.find_by(email: normalized_email)
    # Check if the user exists and the password is correct
    return user if user && user.authenticate(password)

    # Return nil if authentication fails
    nil
  end

  private

  def passwords_match
    return unless password.present? && password_confirmation.present? && password != password_confirmation

    errors.add(:password_confirmation, "doesn't match Password")
  end
end
