class CreateBreweries < ActiveRecord::Migration[5.2]
  def change
    create_table :breweries do |t|
      t.string :name
      t.string :city
      t.string :state
      t.boolean :ba_member
      t.integer :annual_production
      t.integer :founded
      t.timestamps
    end
  end
end
