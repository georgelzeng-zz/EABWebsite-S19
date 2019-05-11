class AnnouncementsController < ApplicationController
  before_action :find_message, only: [:show, :edit, :update, :destroy]

  def index
    @announcements = Announcement.all.order("created_at DESC")
  end

  def show
    @announcement = Announcement.find(params[:id])
  end

  def new
    @announcement = Announcement.new
  end

  def create
    if !(content_params["title"].blank? || content_params["description"].blank?)
      @announcement = Announcement.new(content_params)
      @announcement.save!
    end
    redirect_to announcements_path
  end

  def edit
  end

  def update
    if @announcement.update(content_params)
      redirect_to announcement_path
    end
  end

  def destroy
    @announcement.destroy
    redirect_to announcements_path
  end

  private
    def content_params
      params.require(:announcement).permit(:title, :description)
    end

    def find_message
      @announcement = Announcement.find(params[:id])
    end
end
