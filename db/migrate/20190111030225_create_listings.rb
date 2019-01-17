class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.belongs_to :user, null: false
      t.string :title
      t.string :text
      t.boolean :pets
      t.boolean :verified, default: false
      t.timestamps
    end
  end
end
