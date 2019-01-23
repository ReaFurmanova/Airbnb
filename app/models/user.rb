###########################
# given by rails generate clearance:install
class User < ApplicationRecord
	# has_one_attached :avatar
	mount_uploader :avatar, AvatarUploader
  	include Clearance::User
	has_many :authentications, dependent: :destroy
	has_many :listings
	has_many :reservations

	def self.create_with_auth_and_hash(authentication, auth_hash)
	   user = self.create!(
	     first_name: auth_hash["info"]["name"],
	     email: auth_hash["info"]["email"],
	     # When I use google(or another login) password is compare with providers database
	     # but I still need, wrote something to my database, because if it will nothing in my database, anybody can log in for example just with empty password field
	     # this function choose randomly password
	     password: SecureRandom.hex(10)
	   )
	   user.authentications << authentication
	   return user
	end

	# grab google to access google for user data
	def google_token
	   x = self.authentications.find_by(provider: 'google_oauth2')
	   return x.token unless x.nil?
	end

end
