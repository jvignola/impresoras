class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.boolean :pregunta
      t.text :mensaje

      t.timestamps null: false
    end
  end
end
