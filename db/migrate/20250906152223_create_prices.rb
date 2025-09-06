class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.string :name, null: false
      t.decimal :value, precision: 8, scale: 2, null: false
      t.string :description

      t.timestamps
    end
    
    add_index :prices, :name, unique: true
  end
end
