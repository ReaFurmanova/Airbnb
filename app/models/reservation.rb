class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :listing
	validates :arrival, presence: true
	validates :departure, presence: true
	validates :arrival, :departure, :overlap => {:scope => "listing_id" }
end
