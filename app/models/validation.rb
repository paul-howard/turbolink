class Validation < ActiveRecord::Base

  def before_validation_on_create
    self.phone_num = phone_num.gsub(/[^0-9]/, "")
  end

  validates :phone_num, 
    presence: true,
    uniqueness: true,
    numericality: { only_integer: true },
    length: { is: 10 }

end
