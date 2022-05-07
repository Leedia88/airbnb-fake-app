class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :phone_number
      t.text :description
      t.references :city, index: true
      t.timestamps
    end
  end
end