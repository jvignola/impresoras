class AddReviewsToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :review_comprador_id, :integer
	add_column :orders, :review_vendedor_id, :integer
  end
end
