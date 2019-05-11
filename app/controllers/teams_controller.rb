class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_valid_team_id, except: [:create, :index, :new_team]
  before_action :authenticate_promote_leader_params, only: [:promote_to_leader]
  before_action :ensure_leader, only: [:update]
  before_action :ensure_leader_or_admin, only: [:delete]

  def ensure_valid_team_id
    begin
      @team = Team.find(params[:id])
    rescue
      redirect_to home_path
    end
  end

  def authenticate_promote_leader_params
    @new_leader = User.find(params[:user_id])
    if !current_user.is_leader_of(@team) || !(@team.members.include? @new_leader)
      redirect_to team_path(@team)
    end
  end

  def ensure_leader
    if !current_user.is_leader_of(@team)
      redirect_to home_path
    end
  end

  def ensure_leader_or_admin
    if !current_user.is_leader_of(@team) && !current_user.admin?
      redirect_to home_path
    end
  end

  def index
  	@message = "Hello, #{current_user.first}!"
    @teams = Team.all
  end

  def show
  end

  def create
  end

  def new_team
    if current_user.team == nil
      newTeam = Team.create!(team_params)
      newTeam.user_id = current_user.id
      current_user.team_id = newTeam.id
      newTeam.save!
      current_user.save!
    else
      flash[:alert] = "You can only be in one team!"
    end
    
  	redirect_to teams_path
  end

  def team_params
    params.require(:team).permit(:name, :description, :password, :image)
  end

  def add_member
    if current_user.is_member_of(@team)
      flash[:alert] = "You're already on this team!"
    elsif current_user.has_a_team
      flash[:alert] = "You can be part of only one team!"
    elsif params[:password] == @team.password
      current_user.update!(team_id: @team.id)
      flash[:notice] = "Welcome to the team!"
    else
      flash[:alert] = "Wrong password!"
    end

    redirect_to team_path(@team)
  end

  def promote_to_leader
    @team.user_id = @new_leader.id
    @team.save!
    redirect_to team_path(@team)
  end

  def edit
  end

  def update
    begin
      @team.update!(team_params)
    rescue
      flash[:alert] = "A team with name #{params[:team][:name]} already exists!"
    end
    redirect_to team_path(@team)
  end

  def delete
    team_name = @team.name
    Team.destroy(@team.id)
    flash[:notice] = "Team #{team_name} successfully deleted."
    redirect_to teams_path
  end
end
