class LunchGroupUser < ApplicationRecord
	belongs_to :user
	belongs_to :lunch_group

	validates_uniqueness_of :user_id, :scope => :lunch_group_id

	def self.find_invite(user,group)
		select{ |e| e.user_id == user.id && e.lunch_group_id == group.id }.first
	end
end
