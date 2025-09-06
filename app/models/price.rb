class Price < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :value, presence: true, numericality: { greater_than: 0 }
  
  # Helper methods to get specific prices
  def self.carpet_fitting_cost
    find_by(name: 'carpet_fitting_cost')&.value || 7.50
  end
  
  def self.vinyl_fitting_cost
    find_by(name: 'vinyl_fitting_cost')&.value || 10.50
  end
  
  def self.gripper_rod_price
    find_by(name: 'gripper_rod_price')&.value || 60.30
  end
  
  def self.underlay_price_per_roll
    find_by(name: 'underlay_price_per_roll')&.value || 60.0
  end
  
  def self.spray_adhesive_price
    find_by(name: 'spray_adhesive_price')&.value || 60.0
  end
  
  def self.door_trim_price
    find_by(name: 'door_trim_price')&.value || 9.0
  end
  
  def self.plyboarding_cost
    find_by(name: 'plyboarding_cost')&.value || 10.50
  end
  
  def self.plyboard_price
    find_by(name: 'plyboard_price')&.value || 34.0
  end
  
  def self.min_charge
    find_by(name: 'min_charge')&.value || 150.0
  end
end
