class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.string :type
      t.decimal :amount
      t.string :symbol
      t.integer :receiver_id
      t.integer :sender_id
      t.string :description

      t.timestamps

      t.index :receiver_id
      t.index :type
      t.index :symbol
    end
  end
end
