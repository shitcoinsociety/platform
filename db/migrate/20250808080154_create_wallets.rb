class CreateWallets < ActiveRecord::Migration[8.0]
  def change
    create_table :wallets do |t|
      t.string :type
      t.integer :index, default: 0
      t.string :user_id
      t.string :address

      t.index :user_id
      t.index :address

      t.timestamps
    end
  end
end
