class CreateBeers < ActiveRecord::Migration[5.2]
  def change
    create_table :beers do |t|
      t.string :name
      t.float :abv
      t.integer :ibu
      t.string :style
      t.boolean :limited_release
      t.timestamps
    end
  end
end
