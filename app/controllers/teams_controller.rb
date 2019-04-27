class TeamsController < ApplicationController
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
  	Team.seed_team(current_user.email, name, password)
  	redirect_to teams_path
  end
end
