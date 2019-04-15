class UsersController < ApplicationController
  before_action :authenticate_user!, except: :home
  before_action :authenticate_admin, only: [:admin_index, :registration_code, :admin_code]

  def authenticate_admin
    unless current_user.admin?
      redirect_to home_path
    end
  end

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
    @message = "Hello, #{current_user.first}!"
    @users = User.search(params[:search], false)
    if @users.empty? & params[:search].nil?
      redirect_to users_path
    end
  end

  def admin_index
    @message = "Hello, #{current_user.first}!"
    @users = User.search(params[:search], true)
    if @users.empty? & params[:search].nil?
      redirect_to users_admin_path
    end
  end

  def show
    @message = "Hello, #{current_user.first}!"
    id = params[:id]
    @user = User.find(id)
    @emailName = @user.email.split("@").first
    @emailHost = @user.email.split("@").last.split(".").first
    @emailDomain = @user.email.split(".").last
  end

  def edit
    id = params[:id]
    @user = User.find(id)
  end

  def registration_code
    User.change_registration_code(params[:registration_code])
    redirect_to users_admin_path
  end

  def admin_code
    User.change_admin_code(params[:admin_code])
    redirect_to users_admin_path
  end

  def login
  end

  def forgot
  end

  def create
  end


end
