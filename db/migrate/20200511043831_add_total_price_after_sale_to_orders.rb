class AddTotalPriceAfterSaleToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :price_after_sale, :integer
  end
end
