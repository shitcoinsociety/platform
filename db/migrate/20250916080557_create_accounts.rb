class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.decimal :balance, precision: 20, scale: 8, default: 0.0
      t.string :symbol

      t.timestamps
    end

    add_index :accounts, :user_id
    add_index :accounts, :symbol
  end
end
