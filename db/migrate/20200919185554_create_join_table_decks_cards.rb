class CreateJoinTableDecksCards < ActiveRecord::Migration[6.0]
  def change
    create_join_table :decks, :cards do |t|
      t.index [:deck_id, :card_id]
    end
  end
end
