class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation
  has_secure_password
  
  validates :email, format: { with: /@/, message: 'must be a valid email address.' },
                    uniqueness: { case_sensitive: false, message: "must be a unique email not already in use." },
                    presence: true
                    
  validates :username, length: { maximum: 12, minimum: 6, 
                                 too_short: "must be at least %{count} characters long.",
                                 too_long: "must be less than %{count} characters long." },
                       presence: true,
                       uniqueness: { case_sensitive: false, message: "must be unique and not already taken." }
  
  validates :password, confirmation: true,
                       presence: true,
                       length: { minimum: 6, message: 'must be at least 6 characters long.' }
  
  validates :password_confirmation, presence: true  
end