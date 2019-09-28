class Comment < ApplicationRecord
	validates :content,
		presence: true

	belongs_to :user
	belongs_to :gossip
	has_many :likes, as: :likeable
	belongs_to :commentable, polymorphic: true, optional: true
	has_many :comments, as: :commentable
end
