class CreateDrafters < ActiveRecord::Migration[6.0]
  def change
    create_table :drafters do |t|
      t.string :type
      t.string :name
      t.string :user, index: true
      t.references :draft, index: true
      t.integer :pack_number, default: 0
      t.json :expected_pack
      t.string :state

      t.references :deck

      # Adjacent drafters
      t.references :left, foreign_key: { to_table: 'drafters' }
      t.references :right, foreign_key: { to_table: 'drafters' }

      t.timestamps
    end
  end
end
