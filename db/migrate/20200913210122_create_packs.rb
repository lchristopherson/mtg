class CreatePacks < ActiveRecord::Migration[6.0]
  def change
    create_table :packs do |t|
      t.references :drafter, index: true
      t.string :pass_direction
      t.integer :number

      t.timestamps
    end
  end
end
