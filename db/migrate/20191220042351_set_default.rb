class SetDefault < ActiveRecord::Migration[6.0]
  def change
    change_column :exhibits, :funds, :integer, :default => 0
  end
end
