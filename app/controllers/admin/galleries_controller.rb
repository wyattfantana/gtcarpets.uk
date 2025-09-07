class Admin::GalleriesController < Admin::ApplicationController
  layout 'admin'
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]
  
  def index
    @galleries = Gallery.ordered
  end

  def new
    @gallery = Gallery.new
  end

  def create
    if params[:images].present?
      # Handle multiple image upload
      created_count = 0
      failed_count = 0
      
      params[:images].each_with_index do |image_file, index|
        gallery = Gallery.new(
          image: image_file,
          active: true,
          featured: false,
          position: index + 1
        )
        
        if gallery.save
          created_count += 1
        else
          failed_count += 1
        end
      end
      
      if failed_count == 0
        redirect_to admin_galleries_path, notice: "Successfully uploaded #{created_count} images!"
      else
        redirect_to admin_galleries_path, alert: "Uploaded #{created_count} images, #{failed_count} failed."
      end
    else
      # Handle single image upload (fallback)
      @gallery = Gallery.new(gallery_params)
      @gallery.active = true
      
      if @gallery.save
        redirect_to admin_galleries_path, notice: 'Gallery image added successfully!'
      else
        render :new, alert: 'Error adding gallery image.'
      end
    end
  end

  def edit
  end

  def update
    if @gallery.update(gallery_params)
      redirect_to admin_galleries_path, notice: 'Gallery image updated successfully!'
    else
      render :edit, alert: 'Error updating gallery image.'
    end
  end

  def destroy
    @gallery.destroy
    redirect_to admin_galleries_path, notice: 'Gallery image deleted successfully!'
  end
  
  def bulk_action
    selected_ids = params[:selected_galleries] || []
    
    if selected_ids.empty?
      redirect_to admin_galleries_path, alert: 'No images selected.'
      return
    end
    
    case params[:bulk_action]
    when 'set_homepage'
      # First, remove all current featured images
      Gallery.update_all(featured: false)
      # Then set selected images as featured with sequential positions
      selected_ids.each_with_index do |id, index|
        Gallery.find(id).update(featured: true, position: index + 1)
      end
      redirect_to admin_galleries_path, notice: "Homepage gallery updated with #{selected_ids.count} images."
    when 'delete'
      Gallery.where(id: selected_ids).destroy_all
      redirect_to admin_galleries_path, notice: "#{selected_ids.count} images deleted."
    else
      redirect_to admin_galleries_path, alert: 'Invalid action selected.'
    end
  end
  
  private
  
  def set_gallery
    @gallery = Gallery.find(params[:id])
  end
  
  def gallery_params
    params.require(:gallery).permit(:position, :featured, :image)
  end
end
