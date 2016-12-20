class LinksController < ApplicationController
  before_action :authenticate_user!

  def index
    @link = Link.new
    @current_links = current_user.links
  end

  def create
    # user = current_user
    # @link = user.links.new(link_params)
    #
    # if @link.save
    #   flash.notice = "Successfully added new link"
    #   redirect_to links_path
    # else
    #   flash[:danger] = @link.errors.full_messages.join(", ")
    #   redirect_to links_path
    # end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])

    if @link.update(link_params)
      flash.notice = "Successfully updated link"
      redirect_to links_path
    else
      flash.now[:error] = @link.errors.full_messages.join(', ')
    end
  end

  def read
    link = Link.find(params[:id])
    rls = ReadLinkService.new(link) if link.update(read: true)

    rls.send_read_receipt
    redirect_to links_path
  end

  private
  def link_params
    params.require(:link).permit(:title, :url)
  end
end
