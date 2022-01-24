class Category < ApplicationRecord
	has_many :categories_tasks
	has_many :tasks, through: :categories_tasks
	belongs_to :user
end
