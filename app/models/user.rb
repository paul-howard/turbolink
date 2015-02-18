class User < ActiveRecord::Base

  validates :email,
    presence: true,
    uniqueness: {case_sensitive: false}

  validates :phone_num,
    presence: true,
    uniqueness

  has_secure_password

  validates_confirmation_of :password on: :create
  validates_presence_of :password_confirmation

  def self.authenticate email, password
    User.find_by_email(email).try(:authenticate, password)
  end

end
