# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Like.destroy_all
Comment.destroy_all
JoinTablePmRecipient.destroy_all
PrivateMessage.destroy_all
JoinTableGossipTag.destroy_all
Tag.destroy_all
Gossip.destroy_all
User.destroy_all
City.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!('cities')
ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('gossips')
ActiveRecord::Base.connection.reset_pk_sequence!('tags')
ActiveRecord::Base.connection.reset_pk_sequence!('join_table_gossip_tags')
ActiveRecord::Base.connection.reset_pk_sequence!('private_messages')
ActiveRecord::Base.connection.reset_pk_sequence!('join_table_pm_recipients')
ActiveRecord::Base.connection.reset_pk_sequence!('comments')
ActiveRecord::Base.connection.reset_pk_sequence!('likes')

cities = []
10.times do
	cities << City.create(name: Faker::TvShows::Friends.location, zip_code: Faker::Address.zip_code)
end

users =[]
10.times do
	users << User.create(first_name: Faker::Movies::StarWars.character, last_name: Faker::Name.last_name, description: Faker::Movies::StarWars.quote, email: Faker::Internet.email, age: Faker::Number.number(digits: 2), city: cities.sample)
end

gossips = []
20.times do
	gossips << Gossip.create(title: Faker::Music::Opera.verdi, content: Faker::Movies::BackToTheFuture.quote, user: users.sample)
end

tags = []
10.times do
	tags << Tag.create(title: '#' + Faker::Hacker.ingverb)
end

Gossip.all.each do |gossip|
	rand(1..3).times do
		tag_temp = tags.sample
		join_table_gossip_tag_temp = JoinTableGossipTag.new(gossip: gossip, tag: tag_temp)
		join_table_gossip_tag_temp.save unless JoinTableGossipTag.all.any? {|join_table_gossip_tag| join_table_gossip_tag.gossip == gossip && join_table_gossip_tag.tag == tag_temp}
	end
end

20.times do
	PrivateMessage.create(content: Faker::Movies::HitchhikersGuideToTheGalaxy.quote, sender: User.all.sample)
end

PrivateMessage.all.each do |pm|
	rand(1..3).times do
		recipient_temp = User.all.select{|user| user != pm.sender}.sample
		join_table_pm_recipient_temp = JoinTablePmRecipient.new(received_message: pm, recipient: recipient_temp)
		join_table_pm_recipient_temp.save unless JoinTablePmRecipient.all.any? { |join_table_pm_recipient| join_table_pm_recipient.recipient == recipient_temp && join_table_pm_recipient.received_message == pm }
	end
end

20.times do
	comment = Comment.create(content: Faker::Movies::Lebowski.quote, gossip: Gossip.all.sample, user: User.all.sample)
	rand(0..3).times do #comments of the comment
		Comment.create(content: Faker::Movies::Lebowski.quote, gossip: comment.gossip, user: User.all.sample, commentable: comment)
	end
end

20.times do
	Like.create(user: User.all.sample, likeable: [Gossip.all.sample, Comment.all.sample].sample)
end






