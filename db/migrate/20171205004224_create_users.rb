class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
    	t.string :name
    	t.string :department
    	t.date :start_date
    	t.string :preferred_food
    	t.text :payment_info
    	t.text :interesting_fact
    	t.text :conversation_sensitivities
      t.timestamps
    end
  end
end
