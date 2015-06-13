class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, omniauth_providers: [:twitter, :facebook]

  # validates :name, presence: true
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :identities

  # antes de guardar el usuario, llamar al método default_role
  enum role: [:moderator, :guest]

  before_save :default_role
  def default_role
  	self.role ||= 0
  end

  def email_verified?
   return false if email.blank?
   return false if has_temporal_email?
   true
  end

 private

 def has_temporal_email?
   email.split("@")[1] == "change-me.com"
 end
end
