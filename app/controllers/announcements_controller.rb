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
    @announcement = Announcement.new(content_params)
    if @announcement.save!
      redirect_to announcements_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def content_params
      params.require(:announcement).permit(:title, :description)
    end

    def find_message
      @announcement = Announcement.find(params[:id])
    end
end
