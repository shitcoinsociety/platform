class CreatePositions < ActiveRecord::Migration[8.0]
  def change
    create_table :positions do |t|
      t.integer :user_id
      t.decimal :current, precision: 20, scale: 8, default: 0.0
      t.string :symbol

      t.timestamps
    end

    add_index :positions, :user_id
    add_index :positions, :symbol
  end
end
