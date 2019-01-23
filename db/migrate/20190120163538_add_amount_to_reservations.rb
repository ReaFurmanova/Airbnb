class AddAmountToReservations < ActiveRecord::Migration[5.2]
  def change
  	add_column :reservations, :amount, :integer
  end
end
