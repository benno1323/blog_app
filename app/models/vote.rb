class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :user_id, uniqueness: { scope: :post } # user id es unico por cada post
end
