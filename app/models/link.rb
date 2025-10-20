class Link < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true
  validates :icon, presence: true
  validates :position, presence: true, uniqueness: true

  scope :enabled, -> { where(enabled: true) }
  scope :ordered, -> { order(:position) }

  def self.enabled_ordered
    enabled.ordered
  end
end