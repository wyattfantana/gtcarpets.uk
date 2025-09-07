class AddFeaturedToGalleries < ActiveRecord::Migration[7.0]
  def change
    add_column :galleries, :featured, :boolean, default: false
  end
end
