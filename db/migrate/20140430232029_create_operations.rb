class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.integer :amount
      t.string :comment
      t.boolean :is_income

      t.timestamps
    end
  end
end
