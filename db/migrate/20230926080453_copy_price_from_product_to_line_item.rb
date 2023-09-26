class CopyPriceFromProductToLineItem < ActiveRecord::Migration[7.0]
  def up
    LineItem.all.each do |item|
      item.price = item.product.price
      item.save
    end
  end
end
