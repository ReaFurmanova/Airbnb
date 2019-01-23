class ChangeColumns < ActiveRecord::Migration[5.2]
  def change
  	remove_column :reservations, :country
  	remove_column :reservations, :city
  	add_column :reservations, :state_payment, :boolean, default: false
  	add_column :listings, :images, :json
  	add_column :listings, :city, :string
  	add_column :listings, :country, :string
  	add_column :listings, :price, :integer
  	add_column :listings, :pool, :boolean
  	add_column :listings, :home_type, :string
  end
end
