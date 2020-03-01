class Post < ApplicationRecord

	has_many :category_posts
  	has_many :categories, through: :category_posts
	belongs_to :user
	has_many :comments, dependent: :destroy
	#refile
	attachment :image

	validates :title, presence: true, length: {maximum: 140}
	validates :body, presence: true

end
