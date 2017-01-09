class LinksController < ApplicationController
  def index
    @hot_links = Link.hot
  end

  def update
    @link = Link.find(params[:id])
    @link.update_attributes!(link_params)

    redirect_to links_path
  end

  private

  def link_params
    params.permit(:title, :url, :read)
  end
end
