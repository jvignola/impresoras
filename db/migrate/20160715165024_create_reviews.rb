class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :comment
      t.integer :rating
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
