class CreateValidations < ActiveRecord::Migration
  def change
    create_table :validations do |t|
      t.string :phone_num
      t.string :code
      t.datetime :expiration
      t.boolean :is_used

      t.timestamps null: false
    end
  end
end
