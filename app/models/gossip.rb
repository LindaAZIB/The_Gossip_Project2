class Gossip < ApplicationRecord
	belongs_to :user
	has_many :tags_in_gossips
	has_many :comments
	has_many :likes, as: :element_liked, dependent: :destroy
	has_many :tags, through: :tags_in_gossips

	validates :title, presence: true, length: { in: 3..30, message: "Un titre fait entre 3 et 14 caractères" }
	validates :content, presence: true
end
