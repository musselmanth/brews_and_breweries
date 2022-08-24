class CreateBeers < ActiveRecord::Migration[5.2]
  def change
    create_table :beers do |t|
      t.string :name
      t.float :abv
      t.integer :ibu
      t.sting :style
      t.boolean :limited_realease
      t.timestamps
    end
  end
end
