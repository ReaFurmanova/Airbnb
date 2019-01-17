# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seed Users
user = {}
user['password'] = 'asdf'
# user['password_confirmation'] = 'asdf'

# ActiveRecord::Base.transaction do
#   20.times do 
#     user['first_name'] = Faker::Name.first_name 
#     user['last_name'] = Faker::Name.last_name
#     user['email'] = Faker::Internet.email
#     # user['gender'] = rand(1..2)
#     # user['phone'] = Faker::PhoneNumber.phone_number
#     # user['country'] = Faker::Address.country
#     # user['birthdate'] = Faker::Date.between(50.years.ago, Date.today)
#     User.create(user)
#   end
# end 
####  SEM NAPIS PAK KATEGORIE
####MUSELA JSI JE SMAZNOUT, PROTOZE JSI DROPOVALA TABULKU A TED TI TO DELA POTIZE....sikulka

# Seed Listings
listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  10.times do 
    listing['title'] = Faker::App.name
    listing['text'] = Faker::Hipster.sentence
    listing['pets'] = Faker::Boolean.boolean
    ####not working for picture
    # listing['initial_picture'] = Faker::Avatar.image("https://1.bp.blogspot.com/-8ZjQygZlab4/VOchN_ZlZGI/AAAAAAAAU7Q/0Rgb66aw68g/s1600/Under%2BMatterhorn%2C%2B2%2C600m%2BValais%2BAlps%2C%2BSwitzerland%2B-%2BI%2BAm%2BA%2BMountain%2BPhotographer%2BAnd%2BI%2BSpent%2B6%2BYears%2BPhotographing%2BMy%2BTent%2BIn%2BThe%2BMountains!.jpg", "50x50", "jpg")
    # listing['place_type'] = rand(1..3)
    # listing['property_type'] = ["House", "Entire Floor", "Condominium", "Villa", "Townhouse", "Castle", "Treehouse", "Igloo", "Yurt", "Cave", "Chalet", "Hut", "Tent", "Other"].sample

    # listing['room_number'] = rand(0..5)
    # listing['bed_number'] = rand(1..6)
    # listing['guest_number'] = rand(1..10)

    # listing['country'] = Faker::Address.country
    # listing['state'] = Faker::Address.state
    # listing['city'] = Faker::Address.city
    # listing['zipcode'] = Faker::Address.zip_code
    # listing['address'] = Faker::Address.street_address

    # listing['price'] = rand(80..500)
    

    listing['user_id'] = uids.sample
    ####this one is working for picture
    x = Listing.new(listing)
    x.remote_photos_urls = [Faker::Avatar.image]
    x.save
    end

    Listing.create(listing)
    # listing = Listing.new(listing)
    # listing.save
  end
end
