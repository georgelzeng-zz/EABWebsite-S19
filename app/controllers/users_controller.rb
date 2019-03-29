class UsersController < ApplicationController

  def home
    if current_user
      @message = "Hello, #{current_user.email}!"
    else
      @message = "You aren't logged in!"
    end
  end

  def index
    if current_user
      @message = "Hello, #{current_user.email}!"
      @users = User.all
    else
      redirect_to home_path
    end
  end

  def show
    if current_user
      @message = "Hello, #{current_user.email}!"
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
