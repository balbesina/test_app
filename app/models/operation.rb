class Operation < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :categories, join_table: :categories_operations
	accepts_nested_attributes_for :categories
	validates_presence_of :amount, :date
end
