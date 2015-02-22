class AddUserIdToValidations < ActiveRecord::Migration
  def change
    add_column :validations, :user_id, :integer
    add_index :validations, :user_id
  end
end
