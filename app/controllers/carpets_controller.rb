class CarpetsController < ApplicationController
  def price_calculator
    # Get the parameters from the form
    length = params[:length].to_f
    width = params[:width].to_f
    cost_per_meter = params[:cost_per_meter].to_f
    fitting_cost = params[:fitting_cost].to_f
    extra_charges = params[:extra_charges].to_f

    # Calculate the area
    area = length * width

    # Calculate total cost
    carpet_cost = area * cost_per_meter
    total_fitting_cost = area * fitting_cost
    total_cost = carpet_cost + total_fitting_cost + extra_charges

    # Return the total price to the view
    @total_cost = total_cost
  end
end
