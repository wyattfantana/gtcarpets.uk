class Gallery < ApplicationRecord
  has_one_attached :image
  
  validates :position, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :image, presence: true
  
  scope :active, -> { where(active: true) }
  scope :featured, -> { where(featured: true) }
  scope :ordered, -> { order(:position, :created_at) }
  scope :for_display, -> { active.ordered }
  scope :featured_for_display, -> { active.featured.ordered }
  
  # Helper method to get featured galleries for homepage
  def self.featured_galleries
    featured_for_display.limit(6)
  end
  
  # Helper method to get all display-ready galleries
  def self.display_galleries
    for_display
  end
  
  # Helper to check if gallery section should be shown
  def self.gallery_enabled?
    Setting.enabled?('gallery_enabled') rescue true
  end
  
  # Get the image URL for uploaded file
  def display_image_url
    if image.attached?
      Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
    else
      'https://via.placeholder.com/400x300/f8f9fa/999999?text=No+Image'
    end
  end
  
  # Get display title - use title if present, otherwise use filename
  def display_title
    if title.present?
      title
    elsif image.attached?
      image.filename.to_s.split('.').first.humanize
    else
      'Gallery Image'
    end
  end
  
end
