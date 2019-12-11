class CreateAnimals < ActiveRecord::Migration[6.0]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :species
      t.integer :happiness
      t.string :hunger
      t.string :health

      t.timestamps
    end
  end
end
