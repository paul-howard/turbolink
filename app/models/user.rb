class User < ActiveRecord::Base

  # validations
  validates :email,
    uniqueness: {case_sensitive: false}

  has_secure_password

  validates_presence_of :password_confirmation
  validates_confirmation_of :password, on: :create

  # associations
  has_many :validations

  # methods
  def self.authenticate email, password
    User.find_by_email(email).try(:authenticate, password)
  end

end
