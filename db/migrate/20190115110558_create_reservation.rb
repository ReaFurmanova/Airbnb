class CreateReservation < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
    	t.belongs_to :user
    	t.belongs_to :listing
    	t.string :country
    	t.string :city
    	t.date :arrival
    	t.date :departure
    	t.timestamps
    end
  end
end
