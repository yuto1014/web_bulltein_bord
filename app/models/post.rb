class Post < ApplicationRecord

	belongs_to :category
	belongs_to :user
	has_many :comments, dependent: :destroy
	#refile
	attachment :image

	validates :title, presence: true, length: {maximum: 140}
	validates :body, presence: true

end
