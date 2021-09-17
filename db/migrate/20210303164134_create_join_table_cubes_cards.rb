class CreateJoinTableCubesCards < ActiveRecord::Migration[6.0]
  def change
    create_join_table :cubes, :cards do |t|
      t.index [:cube_id, :card_id]
    end
  end
end
