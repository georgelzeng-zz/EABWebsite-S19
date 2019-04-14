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
      @users = User.search(params[:search], false)
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
      @users = User.search(params[:search], true)
      if @users.empty? & params[:search].nil?
        redirect_to users_admin_path, alert: "No results found! Try keyword(s) again."
      end
    else
      redirect_to home_path
    end
  end

  def show
    if current_user
      @message = "Hello, #{current_user.first}!"
      id = params[:id] 
      @user = User.find(id) 
      @emailName = @user.email.split("@").first
      @emailHost = @user.email.split("@").last.split(".").first
      @emailDomain = @user.email.split(".").last
    else
      @message = "You aren't logged in!"
    end
  end

  def edit
    if current_user
      id = params[:id]
      @user = User.find(id)
    end
  end

  def login
  end

  def forgot
  end

  def create
  end

  
end
