class Validation < ActiveRecord::Base

  def before_validation_on_create
    self.phone_num = phone_num.gsub(/[^0-9]/, "")
  end

  # validations
  validates :phone_num, 
    presence: true,
    numericality: { only_integer: true },
    length: { is: 10 }

  #associations
  belongs_to :user

end
