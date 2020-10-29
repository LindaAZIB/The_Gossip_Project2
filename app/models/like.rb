class Like < ApplicationRecord
	belongs_to :user
	belongs_to :element_liked, polymorphic:true 
end
