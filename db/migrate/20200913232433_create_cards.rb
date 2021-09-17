class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :set
      t.string :category
      t.string :rarity
      t.json :data

      t.timestamps
    end

    add_index :cards, [:name, :set], unique: true
    add_index :cards, [:set, :category, :rarity]
  end
end
