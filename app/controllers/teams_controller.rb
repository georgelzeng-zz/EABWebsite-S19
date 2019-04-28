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
end
