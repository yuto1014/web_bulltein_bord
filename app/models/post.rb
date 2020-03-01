class Post < ApplicationRecord

	has_many :category_posts
  	has_many :categories, through: :category_posts
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :replies, class_name: "Comment", foreign_key: :reply, dependent: :destroy
	#refile
	attachment :image

	validates :title, presence: true, length: {maximum: 140}
	validates :body, presence: true

end
