class Listing < ApplicationRecord
	belongs_to :user
	has_many :reservations
	mount_uploader :initial_picture, InitialPictureUploader
	validates :title, presence: true
end
