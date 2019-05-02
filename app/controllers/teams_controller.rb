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
