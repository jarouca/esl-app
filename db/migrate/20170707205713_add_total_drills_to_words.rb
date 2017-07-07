class AddTotalDrillsToWords < ActiveRecord::Migration[5.0]
  def change
    add_column :words, :total_drills, :integer

  end
end
