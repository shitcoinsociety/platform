class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.string :type
      t.string :symbol
      t.decimal :amount
      t.string :network_id
      t.string :network
      t.integer :confirmations

      t.timestamps

      t.index :user_id
      t.index :network_id
      t.index :created_at
      t.index [ :user_id, :symbol ]
    end
  end
end
