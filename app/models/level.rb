class Level < ApplicationRecord
  belongs_to :goal_template
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
end
