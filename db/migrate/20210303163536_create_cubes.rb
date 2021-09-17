class CreateCubes < ActiveRecord::Migration[6.0]
  def change
    create_table :cubes do |t|
      t.string :name
      t.timestamps
    end

    add_index :cubes, :name, unique: true
  end
end
