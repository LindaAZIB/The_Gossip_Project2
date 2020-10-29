# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

User.destroy_all
City.destroy_all
Gossip.destroy_all
Tag.destroy_all
TagsInGossip.destroy_all
PrivateMessage.destroy_all
Comment.destroy_all
Like.destroy_all

# créer 10 villes
10.times do
	City.create(name:Faker::Address.city, zip_code:Faker::Address.zip)
end

# créer 15 utilisateurs rattachés à une ville
15.times do
	User.create(pseudo:Faker::Games::Pokemon.name, first_name:Faker::Name.first_name, last_name:Faker::Name.last_name, description:Faker::Movies::Ghostbusters.quote, email:Faker::Internet.email, age:rand(10..100), city_id:rand(City.first.id..City.last.id), password:Faker::Creature::Animal.name)
end

# créer 20 potins rattachés à un utilisateur
20.times do
	Gossip.create(title:Faker::Book.title, content:Faker::Movies::HarryPotter.quote, user_id:rand(User.first.id..User.last.id))
end

# créer 10 tags
10.times do
	Tag.create(title:Faker::Coffee.variety)
end

# créer des combinaisons Tag / Gossip avec au moins un tag par gossip
Gossip.all.each do |this_gossip|
	i = rand(3) + 1

	i.times do
		TagsInGossip.create(tag_id:rand(Tag.first.id..Tag.last.id), gossip:this_gossip)
	end
end

# créer des messages privés
50.times do
	PrivateMessage.create(content:Faker::ChuckNorris.fact, sender_id:rand(User.first.id..User.last.id), recipient_id:rand(User.first.id..User.last.id))
end

# créer des commentaires
20.times do
	Comment.create(content:Faker::TvShows::SouthPark.quote, gossip_id:rand(Gossip.first.id..Gossip.last.id), user_id:rand(User.first.id..User.last.id))
end

# mettre des likes sur des commentaires
10.times do
	Like.create(user_id:rand(User.first.id..User.last.id), element_liked:Comment.find(rand(Comment.first.id..Comment.last.id)))
end

# mettre des likes sur des potins
10.times do
	Like.create(user_id:rand(User.first.id..User.last.id), element_liked:Gossip.find(rand(Gossip.first.id..Gossip.last.id)))
end	

# créer des comentaires de commentaires
10.times do
	main_com = Comment.find(rand(Comment.first.id..Comment.last.id))
	Comment.create(content:Faker::TvShows::GameOfThrones.quote, gossip_id:main_com.gossip_id, user_id:rand(User.first.id..User.last.id), main_comment_id:main_com.id)
end