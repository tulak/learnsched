class GoalTemplate < ApplicationRecord
  validates_uniqueness_of :name, scope: :owner_id

  belongs_to :owner, class_name: 'User'
  has_many :levels
  has_many :tasks, through: :levels
end
