class UsersController < ApplicationController
  before_action :authenticate_user!, except: :home
  before_action :authenticate_admin, only: [:admin_index, :registration_code, :admin_code, :download_roster]
  before_action :validate_change_code_params, only: [:change_code]

  def authenticate_admin
    unless current_user.admin?
      redirect_to home_path
    end
  end

  def validate_change_code_params
    redirect_to home_path unless Code.valid_access_levels.include? params[:access_level]
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

  def change_code
    newCode = params[:registration_code] || params[:admin_code]

    begin
      flash[:notice] = User.change_code(params[:access_level], newCode)
    rescue ActiveRecord::RecordInvalid => e
      flash[:notice] = Code.code_uniqueness_message
    end

    redirect_to users_admin_path
  end

  def download_roster
    User.make_XML_file
    file_name = User.roster_file_name

    send_file(
      User.full_file_path,
      filename: file_name,
      type: "application/#{file_name.split('.')[1]}",
      disposition: 'inline'
    )
  end
end
