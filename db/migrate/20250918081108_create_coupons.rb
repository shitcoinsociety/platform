class CreateCoupons < ActiveRecord::Migration[8.0]
  def change
    create_table :coupons do |t|
      t.string :code
      t.float :amount
      t.integer :redeemed_by_id

      t.index :code, unique: true
      t.timestamps
    end
  end
end
