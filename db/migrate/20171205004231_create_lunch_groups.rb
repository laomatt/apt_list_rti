class CreateLunchGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :lunch_groups do |t|
    	t.string :location
    	t.float :bill
    	t.integer :bill_payer_id
      t.timestamps
    end
  end
end
