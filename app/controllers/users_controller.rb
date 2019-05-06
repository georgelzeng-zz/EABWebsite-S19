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

    if !params[:search].nil?
      session[:search] = params[:search]
    end

    User.uncached do
      @users = current_user.search(session[:search], false)
    end

    if !params[:search].nil?
      session[:search] = params[:search]
    end

    if !params[:sort].nil?
      session[:sort] = params[:sort]
    end

    if !params[:direction].nil?
      session[:direction] = params[:direction]
    end

    if @users == User.none
      @users = User.all.order(sort_column + " " + sort_direction)
    else
      User.uncached do
        @users = @users.order(session[:sort] + " " + session[:direction])
      end
    end
  end

  def admin_index
    @message = "Hello, #{current_user.first}!"
    @users = (@users.nil? || params[:search].nil?) ? User.all : ""
    auto_complete(@users)

    if !params[:search].nil?
      session[:search] = params[:search]
    end

    if !params[:sort].nil?
      session[:sort] = params[:sort]
    end

    if !params[:direction].nil?
      session[:direction] = params[:direction]
    end

    @users = current_user.search(session[:search], true)

    if @users == User.none
      @users = User.all
    end

    if !session[:direction].nil?
      if session[:direction] == "asc"
        @users.sort { |a, b| a.send(session[:sort].to_sym) <=> b.send(session[:sort].to_sym)}
      else
        @users.sort { |a, b| b.send(session[:sort].to_sym) <=> a.send(session[:sort].to_sym)}
      end
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
    @user = User.find(params[:id])
  end

  def leave
    @user = User.find(params[:id])
    if !@user.team.nil?
      if @user.team.user_id == params[:id].to_i
        flash[:alert] = "Please ensure that there's another admin for this team."
      else
        @user.team = nil
        @user.save
      end
    end
    redirect_to user_path(@user)
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

  def spreadsheet
    @users =  User.all

    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=\"EAB_roster#{Date.today}.xlsx\""
      }
    end
  end

  private
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "first"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
