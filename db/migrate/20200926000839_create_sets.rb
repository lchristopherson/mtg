class CreateSets < ActiveRecord::Migration[6.0]
  def change
    create_table :sets do |t|
      t.string :name
      t.string :code, index: true
    end
  end
end
