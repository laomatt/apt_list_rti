class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :lunch_group_users

	def past_groups
		LunchGroup.find_records_for(user)
	end

	def find_group_history
		LunchGroup.select do |e| 
			user_array = JSON.parse(e.users_in_this_group)
			user_array.include?(id)
		end
	end

	def current_groups
		# byebug
		lunch_group_users.map { |e| e.lunch_group }
	end
end
