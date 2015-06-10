class Post < ActiveRecord::Base
	has_many :comments
	belongs_to :user
	validates :title, presence: true

	#se define en el modelo al cual se agrego la columna photo
	mount_uploader :photo, PictureUploader
end
