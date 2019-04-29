class UsersController < ApplicationController
  before_action :authenticate_user!, except: :home
  before_action :authenticate_admin, only: [:admin_index, :registration_code, :admin_code, :download_roster]
  before_action :validate_change_code_params, only: [:change_code]

  helper_method :sort_column, :sort_direction

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

  def auto_complete(users)
    @autoComplete = Array.new()
    users.each do |user|
      s = user.first
      s = s + " " + user.last
      @autoComplete.push(s)
    end
  end

  def index
    @message = "Hello, #{current_user.first}!"
    if @users.nil? || params[:search].nil?
      @users = User.all
    end
    auto_complete(@users)

    @users = User.search(params[:search], false) || User.order(sort_column + ' ' + sort_direction)
  end

  def admin_index
    @message = "Hello, #{current_user.first}!"
    @users = (@users.nil? || params[:search].nil?) ? User.all : ""
    auto_complete(@users)
    @users = User.search(params[:search], true) || User.order(sort_column + ' ' + sort_direction)
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
    @user = User.find(params[:id])
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


  private
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "first"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
