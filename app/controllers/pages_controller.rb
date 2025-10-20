class PagesController < ApplicationController
  def home
  end

  def links
    @links = Link.enabled_ordered
    render layout: false
  end
end
