class ChangeAmountFormatInOperations < ActiveRecord::Migration
  def change
  	change_column :operations, :amount, :float
  end
end
