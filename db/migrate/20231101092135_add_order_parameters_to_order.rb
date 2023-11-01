class AddOrderParametersToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :credit_card_number, :integer
    add_column :orders, :expiration_date, :string
    add_column :orders, :routing_number, :integer
    add_column :orders, :account_number, :integer
    add_column :orders, :po_number, :integer
  end
end
