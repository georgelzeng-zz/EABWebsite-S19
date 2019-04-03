class UsersController < ApplicationController

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
      @users = User.all

      @search = params["search"]

      if @search.present?
        @name = @search["name"]
        if !@name.blank?
          @users = User.where("lower(first) = lower(?)", "#{@name}")
          if @users.empty?
            @message = "No results for #{@name}."
            redirect_to users_path
          end
        end
      end
    else
      redirect_to home_path
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
