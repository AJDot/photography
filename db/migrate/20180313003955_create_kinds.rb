class CreateKinds < ActiveRecord::Migration[5.1]
  def change
    create_table :kinds do |t|
      t.string :name
      t.text :gist, :description
      t.integer :price
      t.text :price_description
      t.string :banner, :cover_image
      t.timestamps
    end
  end
end
