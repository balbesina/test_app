class Category < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :operations, join_table: :categories_operations
  validates_presence_of :name
end
