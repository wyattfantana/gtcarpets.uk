class MakeTitleOptionalInGalleries < ActiveRecord::Migration[7.0]
  def change
    change_column_null :galleries, :title, true
  end
end
