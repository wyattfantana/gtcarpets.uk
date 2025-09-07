class Admin::SettingsController < Admin::ApplicationController
  layout 'admin'
  
  def index
    @settings = Setting.all.order(:key)
  end

  def edit
    @setting = Setting.find(params[:id])
  end

  def update
    @setting = Setting.find(params[:id])
    
    if @setting.update(setting_params)
      redirect_to admin_path, notice: 'Setting updated successfully!'
    else
      redirect_to admin_path, alert: 'Error updating setting.'
    end
  end
  
  private
  
  def setting_params
    params.require(:setting).permit(:value, :description)
  end
end
