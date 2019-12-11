class CreateActions < ActiveRecord::Migration[6.0]
  def change
    create_table :actions do |t|
      t.string :action_type
      t.integer :user_id
      t.integer :animal_id

      t.timestamps
    end
  end
end
