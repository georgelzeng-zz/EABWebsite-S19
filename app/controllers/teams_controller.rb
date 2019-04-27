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

  def new_project
	  name = params['name']['name']
  	sid = params['admin']['admin']
  	Team.create!(name: name, admin: sid)
  	redirect_to projects_path
  end
end
