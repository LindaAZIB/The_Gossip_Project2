class City < ApplicationRecord
	has_many :users
	has_many :gossips, through: :users
	validates :name, presence: true
	validates :zip_code, presence: true, length: {is: 5}

	def self.exists(this_city_name)
		!City.find_by(name: this_city_name).nil?
	end

end