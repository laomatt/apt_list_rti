class LunchGroup < ApplicationRecord
	has_many :lunch_group_users

	def self.current_groups
		# select groups that currently have users in them
		select {|e| e.lunch_group_users.count > 0}
	end

	def self.find_records_for(user)
		select do |e| 
			user_array = JSON.parse(e.users_in_this_group)
			user_array.include?(user.id)
		end
	end

	def lunch_group_users_list
		if lunch_group_users.empty?
			out = JSON.parse(users_in_this_group).map { |e| User.find(e) }
		else
			out = lunch_group_users.map { |e| e.user }
		end
		out
	end

	def is_past?
		lunch_group_users.empty?
	end

	def number_people
		lunch_group_users.count
	end

	def all_confirmed?
		lunch_group_users.all? { |e| e.confirmed }
	end

	def add_another(user)
    people = JSON.parse(users_in_this_group)
    people << user.id
    update_attributes(:users_in_this_group => people.to_json)
	end

end
