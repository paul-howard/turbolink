class User < ActiveRecord::Base

  # validations
  validates :email,
    presence: true,
    uniqueness: {case_sensitive: false}

  has_secure_password

  validates_confirmation_of :password, on: :create
  validates_presence_of :password_confirmation

  # associations
  has_many :validations

  # methods
  def self.authenticate email, password
    User.find_by_email(email).try(:authenticate, password)
  end

end
