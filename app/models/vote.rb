class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :user_id, uniqueness: { scope: :post } # user id es unico por cada post
  belongs_to :votable, polymorphic: :true
  after_create :add_count

  def add_count
  	self.post.votes_count += 1
  	self.post.save
  end
end
