class Tag < ApplicationRecord
	has_many :tags_in_gossips
	has_many :gossips, through: :tags_in_gossips

	validates :title, presence: true, length: { in: 3..14, message: "Un tag fait entre 3 et 14 caractères" }
end
