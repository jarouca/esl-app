class AddBankIdToWords < ActiveRecord::Migration[5.0]
  def change
    add_column :words, :bank_id, :integer
  end
end
