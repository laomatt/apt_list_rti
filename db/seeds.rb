# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


40.times do 
	user = User.new(:email => Faker::Internet.safe_email, :name => Faker::Internet.user_name, :avatar_url => Faker::Avatar.image("my-own-slug", "50x50"), :password => 'password')
	if !user.save
		p user.errors.full_messages
	end
end
