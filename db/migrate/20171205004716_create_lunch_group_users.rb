class CreateLunchGroupUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :lunch_group_users do |t|
    	t.integer :lunch_group_id
    	t.integer :user_id
    	t.boolean :confirmed, :default => false
      t.timestamps
    end
  end
end
