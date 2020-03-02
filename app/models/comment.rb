class Comment < ApplicationRecord

    belongs_to :user
	belongs_to :post
	#バリデーション
	validates :content, presence: true

end
