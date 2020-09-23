class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :set, index: true
      t.string :rarity, index: true
      t.json :data

      t.timestamps
    end
  end
end
