class AddAclaracionToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :aclaracion, :string
  end
end
