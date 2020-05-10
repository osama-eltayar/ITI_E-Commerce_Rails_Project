class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.string :name, null: false
      t.date :expiration_date,null: false
      t.integer :usage_limit,null: false
      t.string :deduction_type,null: false
      t.integer :deduction_amount,null: false
      t.boolean :expired

      t.timestamps
    end
  end
end
