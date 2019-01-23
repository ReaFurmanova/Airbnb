class Listing < ApplicationRecord
	belongs_to :user
	has_many :reservations, dependent: :destroy
	####dependent: :destroy - mela jsem nil class, protoze jsem vymazala listing, ale rezervace tam stale byla, tohle kdyz vymaze listing, vymaze i rezervace
	mount_uploaders :images, AvatarUploader
	validates :title, :price, presence: true
	validates :country, presence: true
	scope :city, -> (city) {where("city ilike ?", "%#{city}%")}
	#### when i have just like and i will write prague (right is Prague) it not find anything, but ilike in not case sensitive
	#scope :price, -> (price) {where("price <= ?", price)}
	#### vrchni scope je jen pro jedno cenove policko, najde cislo zadane a mensi
	scope :price_min, -> (min) {where("price >= ?", min)}
	####prvni mi rika jak jse jmenuje parametr, druhy nahradi otaznik
	####vic otazniku vic parametru zadavam
	#scope :price, -> (abc) {where("price > ?", abc)}
	####ukazka s abc
	scope :price_max, -> (max) {where("price <= ?", max)}
	####prvni min se muze jmenovat jakkoliv abc
	#### :price_max apod neodkazuji na sloupecek v databazi (to co je za scope)
	scope :pool, -> {where(pool: true)}
	scope :pets, -> {where(pets: true)}
	scope :home_type, -> (home_type) {where("home_type = ?",home_type)}
	####zadni home_type nahrazuje otaznik, params z controleru prijde do predniho, pak dozadu
end
