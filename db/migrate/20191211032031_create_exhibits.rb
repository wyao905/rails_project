class CreateExhibits < ActiveRecord::Migration[6.0]
  def change
    create_table :exhibits do |t|
      t.string :name
      t.integer :funds
      t.boolean :claimed, :default => false

      t.timestamps
    end
  end
end
