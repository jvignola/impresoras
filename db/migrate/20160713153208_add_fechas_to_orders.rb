class AddFechasToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :fecha_autorizado, :datetime
    add_column :orders, :fecha_entregado, :datetime
  end
end
