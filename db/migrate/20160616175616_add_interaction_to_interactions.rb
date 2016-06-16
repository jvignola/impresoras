class AddInteractionToInteractions < ActiveRecord::Migration
  def change
    add_reference :interactions, :interaction, index: true, foreign_key: true
  end
end
