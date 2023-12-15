class ChangeIntegerLimitInOrders < ActiveRecord::Migration[7.0]
  def change
    change_column :orders, :credit_card_number, :integer, limit: 8
    change_column :orders, :account_number, :integer, limit: 8
    change_column :orders, :routing_number, :integer, limit: 8
  end
end
