class GalleryController < ApplicationController
  def index
    @galleries = Gallery.display_galleries
  end
end
