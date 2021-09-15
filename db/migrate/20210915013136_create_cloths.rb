class CreateCloths < ActiveRecord::Migration[5.0]
  def change
    create_table :cloths do |t|
      t.integer :category_item_id
      t.integer :category_color_id
      t.integer :category_season_id
      t.string :image
      t.date :date
      t.string :memo
      t.integer :price

      t.timestamps
    end
  end
end
