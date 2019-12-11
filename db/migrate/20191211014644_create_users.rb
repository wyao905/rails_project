class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.integer :balance
      t.boolean :zookeeper
      t.string :donation_status
      t.string :password_digest

      t.timestamps
    end
  end
end
