class Environment < ApplicationRecord
  validates :user_id,
    presence: true
  validates :name,
    presence: true

  belongs_to :user
  has_many :shortcuts
  has_and_belongs_to_many :non_confricting_groups
end
