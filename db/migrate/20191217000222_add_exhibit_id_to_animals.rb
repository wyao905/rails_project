class AddExhibitIdToAnimals < ActiveRecord::Migration[6.0]
  def change
    add_column :animals, :exhibit_id, :integer
  end
end
