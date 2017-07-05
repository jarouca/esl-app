class CreateDrills < ActiveRecord::Migration[5.0]
  def change
    create_table :drills do |t|
      t.integer :bank_id, null: false
      t.integer :user_id, null: false
    end
  end
end
