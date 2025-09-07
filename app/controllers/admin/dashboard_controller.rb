class Admin::DashboardController < Admin::ApplicationController
  layout 'admin'
  
  def index
    # Get all settings organized by section
    @about_us = Setting.find_by(key: 'about_us')
    @our_expertise = Setting.find_by(key: 'our_expertise')
    @contact_name = Setting.find_by(key: 'contact_name')
    @contact_phone = Setting.find_by(key: 'contact_phone')
    @contact_email = Setting.find_by(key: 'contact_email')
    @calculator_enabled = Setting.find_by(key: 'calculator_enabled')
    @gallery_enabled = Setting.find_by(key: 'gallery_enabled')
    
    # Get all prices organized by category
    @fitting_prices = Price.where(name: ['carpet_fitting_cost', 'vinyl_fitting_cost']).order(:name)
    @material_prices = Price.where(name: ['gripper_rod_price', 'underlay_price_per_roll', 'spray_adhesive_price', 
                                         'door_trim_price', 'plyboarding_cost', 'plyboard_price']).order(:name)
    @other_prices = Price.where(name: 'min_charge')
    
    # Get gallery items for management
    @galleries = Gallery.ordered.limit(5)
    @gallery_count = Gallery.count
  end
end
