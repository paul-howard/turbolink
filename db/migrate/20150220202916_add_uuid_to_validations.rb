class AddUuidToValidations < ActiveRecord::Migration
  def change
    add_column :validations, :uuid, :string
  end
end
