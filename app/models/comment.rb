class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :content, presence: true

  mount_uploader :photo, PictureUploader
end
