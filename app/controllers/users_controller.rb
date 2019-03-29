class UsersController < ApplicationController

  def home
    if current_user
      @message = "Hello, #{current_user.email}!"
    else
      @message = "You aren't logged in!"
    end
  end

  def index
  end

  def show
    redirect_to home_path
  end

  def login
  end

  def forgot
  end

  def create
  end
end
