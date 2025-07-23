class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest

      t.string :email_verification_token
      t.datetime :email_verified_at

      t.references :referrer, foreign_key: { to_table: :users }
      t.string :referral_code

      t.string :locale, default: "en"
      t.timestamps

      t.index :email
      t.index :referral_code, unique: true
      t.index :email_verification_token, unique: true
    end
  end
end
