class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation
  has_secure_password
  after_create :generate_sign_up_token, :send_welcome_message
  
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
  
  scope :active_users, where(active: true)
  
  def generate_sign_up_token
    require 'securerandom'
    self.update_attribute(:sign_up_token, SecureRandom.uuid)
  end
  
  def send_welcome_message
    UserMailer.welcome_message(self).deliver
  end
  
  def activate_user
    self.update_attribute(:active, true)
  end
  
  def deactivate_user
    self.update_attribute(:active, false)
  end
  
end