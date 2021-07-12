class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.string :brand
      t.string :model
      t.integer :monetary_price
      t.boolean :new
      t.string :dealerships, array: true, default: []

      t.timestamps
    end
  end
end
