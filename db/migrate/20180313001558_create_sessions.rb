class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.integer :user_id, :kind_id
      t.string :title
      t.date :date
      t.text :gist, :description
      t.json :images
      t.string :cover
      t.timestamps
    end
  end
end
