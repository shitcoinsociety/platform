class CreatePrices < ActiveRecord::Migration[8.0]
  def change
    create_table :prices do |t|
      t.string :base, null: false
      t.string :quote, null: false
      t.float :value, null: false

      t.timestamp :delete_at
      t.timestamps

      t.index [ :base, :quote ]
      t.index :delete_at
    end
  end
end
