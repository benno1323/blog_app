class Post < ActiveRecord::Base
	belongs_to :user
	has_many :votes
	has_many :users_who_voted, through: :votes, source: :user # o puede ser has_many :users
	has_many :comments

	validates :title, presence: true

	#se define en el modelo al cual se agrego la columna photo
	mount_uploader :photo, PictureUploader
end
