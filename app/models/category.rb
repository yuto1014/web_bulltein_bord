class Category < ApplicationRecord

	has_many :category_posts
  	has_many :posts, through: :category_posts

	validates :name, presence: true

end
