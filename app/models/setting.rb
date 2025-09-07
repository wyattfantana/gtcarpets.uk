class Setting < ApplicationRecord
  validates :key, presence: true, uniqueness: true
  
  # Helper method to get setting values
  def self.get(key)
    return nil unless table_exists?
    find_by(key: key)&.value
  rescue ActiveRecord::StatementInvalid
    nil
  end
  
  # Helper method to get setting with fallback
  def self.get_or_default(key, default_value)
    get(key) || default_value
  end
  
  # Helper method to set a value
  def self.set(key, value, description = nil)
    setting = find_or_initialize_by(key: key)
    setting.value = value
    setting.description = description if description.present?
    setting.save!
  end
  
  # Boolean helper for toggles
  def self.enabled?(key)
    get(key) == 'true'
  end
end
