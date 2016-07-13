class AddAgotadoToProducts < ActiveRecord::Migration
  def change
    add_column :products, :agotado, :boolean, default: false
  end
end
