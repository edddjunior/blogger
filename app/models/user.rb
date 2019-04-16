class User < ApplicationRecord
	has_many :posts, :dependent => :destroy
	has_many :comments, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.email = auth.info.email
		  user.name = auth.info.name
		  user.password = Devise.friendly_token[0,20]
		end
	end
end
