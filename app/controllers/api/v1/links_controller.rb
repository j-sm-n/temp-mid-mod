class Api::V1::LinksController < ApplicationController

  def create
    @link = Link.new( title: link_params[:title],
                      url: link_params[:url],
                      user_id: current_user.id )
    if @link.save
      render json: @link, status: 201
    else
      render json: @link.errors.full_messages, status: 500
    end
  end

  def update
    @link = Link.find params[:id]
    @link.assign_attributes link_params
    just_read = @link.read_changed? && @link.read
    if @link.save
      read = Read.create(link: @link) if just_read
      ReadService.new(read)
      head :no_content
    else
      render json: @link.errors.full_messages, status: 500
    end
  end

  def index
    @links = Link.where(user_id: current_user.id)
    if @links
      render json: @links, status: 200
    else
      render json: { "error": "No links for you"}, status: 500
    end
  end

  private

  def link_params
    params.permit(:title, :url, :read, :id)
  end
end
