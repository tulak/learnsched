class User < ApplicationRecord

  has_many :goal_templates, foreign_key: :owner_id
  has_many :goals
  has_many :tasks, through: :goals
  has_many :task_schedules, through: :goals

  validates_uniqueness_of :email

  def self.encrypt_password password
    Digest::SHA2.hexdigest password
  end

  def name
    "#{first_name} #{last_name}"
  end
end
