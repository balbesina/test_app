class AddUserRefToOperations < ActiveRecord::Migration
  def change
    add_reference :operations, :user, index: true
  end
end
