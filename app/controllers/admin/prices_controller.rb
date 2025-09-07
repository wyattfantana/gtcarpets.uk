class Admin::PricesController < Admin::ApplicationController
  layout 'admin'
  
  def index
    @prices = Price.all.order(:name)
  end

  def edit
    @price = Price.find(params[:id])
  end

  def update
    @price = Price.find(params[:id])
    
    if @price.update(price_params)
      redirect_to admin_path, notice: 'Price updated successfully!'
    else
      redirect_to admin_path, alert: 'Error updating price.'
    end
  end

  def reset_defaults
    # Default values from original hardcoded prices
    defaults = {
      'carpet_fitting_cost' => 7.50,
      'vinyl_fitting_cost' => 10.50,
      'gripper_rod_price' => 60.30,
      'underlay_price_per_roll' => 60.00,
      'spray_adhesive_price' => 60.00,
      'door_trim_price' => 9.00,
      'plyboarding_cost' => 10.50,
      'plyboard_price' => 34.00,
      'min_charge' => 150.00
    }
    
    defaults.each do |name, value|
      price = Price.find_by(name: name)
      price&.update(value: value)
    end
    
    redirect_to admin_path, notice: 'All prices reset to default values!'
  end
  
  private
  
  def price_params
    params.require(:price).permit(:value, :description)
  end
end
