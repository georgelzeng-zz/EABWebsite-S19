class AnnouncementsController < ApplicationController
  def index
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcemeent.new(content_params)
  end

  private
    def content_params
      params.require(:announcement).permit(:title, :description)
    end

end
