class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  # antes de guardar el usuario, llamar al método default_role
  enum role: [:moderator, :guest]

  before_save :default_role
  def default_role
  	self.role ||= :guest
  end
end
