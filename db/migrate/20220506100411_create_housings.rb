class CreateHousings < ActiveRecord::Migration[5.2]
  def change
    create_table :housings do |t|
      t.integer :available_beds
      t.integer :price
      t.text :description
      t.boolean :has_wifi
      t.text :welcome_message
      t.references :admin, index: true
      t.references :city, index: true
      t.timestamps
    end
  end
end
