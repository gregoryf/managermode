class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation
  has_secure_password
  
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :password, length: {
    minimum: 6,
    message: 'must be at least 6 characters long.'
  }
  validates :email, format: { with: /@/, message: 'must be a valid email address.' }
  validates :email, :uniqueness: {
    case_sensitive: false,
    message: "must be a unique email not already in use."
  }
  validates :username, length: { 
    maximum: 12,
    minimum: 6,
    too_short: "must be at least %{count} characters long."
    too_long: "must be less than %{count} characters long."
  }
  validates :username, presence: true
  validates :username, uniqueness: {
    case_sensitive: false,
    message: "must be unique and not already taken."
  }
end
