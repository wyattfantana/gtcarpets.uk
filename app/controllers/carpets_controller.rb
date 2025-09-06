class CarpetsController < ApplicationController
  def price_calculator
    # Get the parameters from the form
    length = params[:length].to_f
    width = params[:width].to_f
    fitting_type = params[:fitting_type] # Carpet or Vinyl
    door_trims = params[:door_trims].to_i
    
    # Get prices from database (with fallback to hardcoded values)
    carpet_fitting_cost = Price.carpet_fitting_cost
    vinyl_fitting_cost = Price.vinyl_fitting_cost
    gripper_rod_price = Price.gripper_rod_price
    underlay_price_per_roll = Price.underlay_price_per_roll
    spray_adhesive_price = Price.spray_adhesive_price
    door_trim_price = Price.door_trim_price
    plyboarding_cost = Price.plyboarding_cost
    plyboard_price = Price.plyboard_price
    min_charge = Price.min_charge

    # Calculate area
    @area = length * width

    # Determine fitting cost
    @fitting_cost = fitting_type == 'carpet' ? carpet_fitting_cost : vinyl_fitting_cost

    # Calculate total fitting cost
    total_fitting_cost = @area * @fitting_cost

    # Calculate spray adhesive cost (1 tin per 10 sqm)
    total_spray_adhesive_cost = (@area / 10).ceil * (spray_adhesive_price / 12)

    # Calculate other costs (gripper rods, underlay, door trims, plyboarding)
    total_gripper_rod_cost = params[:gripper_rods] == 'yes' ? (@area / 152).ceil * gripper_rod_price : 0
    total_underlay_cost = params[:underlay] == 'yes' ? (@area / 15).ceil * underlay_price_per_roll : 0
    total_door_trim_cost = door_trims * door_trim_price

    # Plyboarding cost (if vinyl selected)
    total_plyboarding_cost = 0
    if fitting_type == 'vinyl' && params[:plyboarding] == 'yes'
      total_plyboarding_cost = @area * plyboarding_cost
      total_plyboard_cost = (@area / 2.9768).ceil * plyboard_price
      total_plyboarding_cost += total_plyboard_cost
    end

    # Total material cost
    total_material_cost = total_gripper_rod_cost + total_underlay_cost + total_spray_adhesive_cost + total_door_trim_cost + total_plyboarding_cost

    # Final total cost
    @total_cost = total_fitting_cost + total_material_cost

    # Apply minimum charge if necessary
    @total_cost = [@total_cost, min_charge].max

    # Format the final total cost for display
    @formatted_cost = @total_cost.round(2)

    # Render the view
    render 'price_calculator'
  end
end
