class CreateAssets < ActiveRecord::Migration[8.0]
  def change
    create_table :assets do |t|
      t.integer :user_id
      t.decimal :amount, precision: 20, scale: 8, default: 0.0
      t.string :symbol

      t.timestamps
    end

    add_index :assets, :user_id
    add_index :assets, :symbol
  end
end
