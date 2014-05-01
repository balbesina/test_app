class AddColumnToOperations < ActiveRecord::Migration
  def change
    add_column :operations, :date, :datetime
  end
end
