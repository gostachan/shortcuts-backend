class Shortcut < ApplicationRecord
  validates :environment_id,
    presence: true
  validates :command,
    presence: true
  validates :key_binding,
    presence: true
  validates :condition,
    presence: true

  belongs_to :environment

  def as_json(options = {})
    super(options.merge(methods: :environment_name))
  end

  def environment_name
    environment.name
  end
end
