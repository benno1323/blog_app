class Post < ActiveRecord::Base
	belongs_to :user
	has_many :votes, as: :votable
	has_many :users_who_voted, through: :votes, source: :user # o puede ser has_many :users
	has_many :comments, dependent: :destroy

	validates :title, presence: true

	paginates_per 25

	#se define en el modelo al cual se agrego la columna photo
	mount_uploader :photo, PictureUploader
end
