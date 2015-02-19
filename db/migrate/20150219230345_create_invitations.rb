class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :from_user
      t.string :to_phone
      t.string :as_role
      t.datetime :expiration
      t.boolean :is_used

      t.timestamps null: false
    end
  end
end
