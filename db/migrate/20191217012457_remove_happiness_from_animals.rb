class RemoveHappinessFromAnimals < ActiveRecord::Migration[6.0]
  def change

    remove_column :animals, :happiness, :integer
  end
end
