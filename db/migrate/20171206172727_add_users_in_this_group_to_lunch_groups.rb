class AddUsersInThisGroupToLunchGroups < ActiveRecord::Migration[5.0]
  def change
  	add_column :lunch_groups, :users_in_this_group,:string
  end
end
