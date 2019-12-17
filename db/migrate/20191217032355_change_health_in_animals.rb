class ChangeHealthInAnimals < ActiveRecord::Migration[6.0]
  def change
    change_column :animals, :health, :boolean
    rename_column :animals, :health, :sick
    change_column_default(:animals, :sick, false)
  end
end
