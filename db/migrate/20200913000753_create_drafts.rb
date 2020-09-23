class CreateDrafts < ActiveRecord::Migration[6.0]
  def change
    create_table :drafts do |t|
      t.string :owner
      t.string :state
      t.json :data

      t.timestamps
    end
  end
end
