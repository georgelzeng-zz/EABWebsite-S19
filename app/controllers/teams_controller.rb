class TeamsController < ApplicationController
  before_action :authenticate_user!

  def index
  	@message = "Hello, #{current_user.first}!"
    @teams = Team.all
  end

  def show
  	id = params[:id]
    @team = Team.find(id)
  end

  def create
  end

  def new_team
	  name = params['name']
    description = params['description']
  	password = params['password']

    if current_user.team == nil
      Team.seed_team(current_user.email, name, password)
    else
      flash[:alert] = "You can only be in one team!"
    end

  	redirect_to teams_path
  end

  def add_member
    id = params[:id]
    @team = Team.find(id)

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
end
