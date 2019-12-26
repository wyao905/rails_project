class RemoveClaimedFromExhibits < ActiveRecord::Migration[6.0]
  def change
    remove_column :exhibits, :claimed, :boolean
  end
end
