class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }


  validates :password, presence: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true

  private

  def passwords_must_match
    return if password == password_confirmation
    
    errors.add(:password_confirmation, "does not match password")
  end

  def self.authenticate_with_credentials(email, password)
    trimmed_email = email.strip.downcase
    user = User.find_by('lower(email) = ?', trimmed_email)

    if user && user.authenticate(password)
      user
    else
      nil
    end
  end




end
