class Category < ApplicationRecord

	has_many :posts

	validates :name, presence: true
	accepts_nested_attributes_for :posts, allow_destroy: true

end
