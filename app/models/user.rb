class User < ActiveRecord::Base
	has_many :categories, dependent: :destroy
	has_many :operations, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end