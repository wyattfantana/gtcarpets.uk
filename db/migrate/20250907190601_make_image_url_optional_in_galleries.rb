class MakeImageUrlOptionalInGalleries < ActiveRecord::Migration[7.0]
  def change
    change_column_null :galleries, :image_url, true
  end
end
