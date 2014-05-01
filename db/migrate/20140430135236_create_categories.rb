class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :is_income
      t.references :user, index: true

      t.timestamps
    end
  end
end
