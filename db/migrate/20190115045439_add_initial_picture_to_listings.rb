class AddInitialPictureToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :initial_picture, :string
    # if I want more pictures I have to use :json
  end
end
