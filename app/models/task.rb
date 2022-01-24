class Task < ApplicationRecord
	has_many :categories_tasks
	has_many :categories, through: :categories_tasks
	belongs_to :user
end
