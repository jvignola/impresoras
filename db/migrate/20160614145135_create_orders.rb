class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.boolean :autorizado
      t.boolean :entregado
      t.integer :cantidad

      t.timestamps null: false
    end
  end
end
