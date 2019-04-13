class Post < ApplicationRecord
	belongs_to :user
	has_many :comments, :dependent => :destroy
	has_one_attached :image

	validates :user_id, presence: true
	validates :title, presence: true
  validates :body, presence: true
end
