class CreateTemps < ActiveRecord::Migration[5.0]
  def change
    create_table :temps do |t|
    	t.string :name
    	t.string :email
    	t.string :password
    	t.string :val_code
    	t.string :avatar_url
      t.timestamps
    end
  end
end
