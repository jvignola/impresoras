class AddRespondidaToInteractions < ActiveRecord::Migration
  def change
    add_column :interactions, :respondida, :boolean
  end
end
