class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @projects = Project.all
  end

  def new
    @projects = Project.all
    render :layout => 'pages'
  end

end
