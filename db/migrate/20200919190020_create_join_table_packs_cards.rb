class CreateJoinTablePacksCards < ActiveRecord::Migration[6.0]
  def change
    create_join_table :packs, :cards do |t|
       t.index [:pack_id, :card_id]
    end
  end
end
