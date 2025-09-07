class CreateGalleries < ActiveRecord::Migration[7.0]
  def change
    create_table :galleries do |t|
      t.string :title, null: false
      t.string :image_url, null: false
      t.text :description
      t.integer :position, default: 0
      t.boolean :active, default: true

      t.timestamps
    end
    
    add_index :galleries, [:active, :position]
  end
end
