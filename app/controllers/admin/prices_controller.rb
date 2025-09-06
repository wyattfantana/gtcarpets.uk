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
      redirect_to admin_prices_path, notice: 'Price updated successfully!'
    else
      render :edit, alert: 'Error updating price.'
    end
  end
  
  private
  
  def price_params
    params.require(:price).permit(:value, :description)
  end
end
