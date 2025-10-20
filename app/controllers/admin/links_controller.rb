class Admin::LinksController < Admin::ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  def index
    @links = Link.ordered
  end

  def show
  end

  def new
    @link = Link.new
    @link.position = (Link.maximum(:position) || 0) + 1
  end

  def create
    @link = Link.new(link_params)

    if @link.save
      redirect_to admin_links_path, notice: 'Link was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @link.update(link_params)
      redirect_to admin_links_path, notice: 'Link was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @link.destroy
    redirect_to admin_links_path, notice: 'Link was successfully deleted.'
  end

  def bulk_action
    action = params[:bulk_action]
    link_ids = params[:link_ids] || []

    case action
    when 'enable'
      Link.where(id: link_ids).update_all(enabled: true)
      redirect_to admin_links_path, notice: "#{link_ids.count} links enabled."
    when 'disable'
      Link.where(id: link_ids).update_all(enabled: false)
      redirect_to admin_links_path, notice: "#{link_ids.count} links disabled."
    when 'delete'
      Link.where(id: link_ids).destroy_all
      redirect_to admin_links_path, notice: "#{link_ids.count} links deleted."
    else
      redirect_to admin_links_path, alert: 'Invalid action selected.'
    end
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:title, :description, :url, :icon, :position, :enabled)
  end
end