class UsersController < ApplicationController
  before_action :authenticate_user!, except: :home

  def home
    if current_user
      if !flash[:notice].blank?
        @message = flash[:notice]
      else
        @message = "Hello, #{current_user.first}!"
      end
    else
      @message = "You aren't logged in!"
    end
  end

  def index
    if current_user
      @message = "Hello, #{current_user.first}!"
      @users = User.search(params[:search])
      if @users.empty? & params[:search].nil?
        redirect_to users_path, alert: "No results found! Try keyword(s) again."
      end
    else
      redirect_to home_path
    end

  end

  def admin_index
    if current_user.admin?
      @message = "Hello, #{current_user.first}!"
      # set allowed view params tbd
      @users = User.search(params[:search])
    else
      redirect_to users_path
    end
  end

  def show
    if current_user
      @message = "Hello, #{current_user.first}!"
      id = params[:id] # retrieve movie ID from URI route
      @user = User.find(id) # look up movie by unique ID
    else
      @message = "You aren't logged in!"
    end
  end

  def login
  end

  def forgot
  end

  def create
  end
end
