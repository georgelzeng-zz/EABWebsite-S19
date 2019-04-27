class ProjectsController < ApplicationController
  def index
  	@message = "Hello, #{current_user.first}!"
    @projects = Project.all.each
  end

  def show
  	id = params[:id]
    @project = Project.find(id)
  end

  def create
  end

  def new_project
	name = params['name']['name']
  	sid = params['admin']['admin']
  	Project.create!(name: name, admin: sid)
  	redirect_to projects_path
  end
end
