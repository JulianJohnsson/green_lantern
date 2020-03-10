class BadgesController < ApplicationController
  before_action :authenticate_user!

  def index
    @badges = Badge.where("active = true")
  end

  def calcul
    @badge = Badge.find(1)
  end

  def add
    @badge = Badge.find(params[:badge])
    unless current_user.badges.include?(@badge)
      current_user.badges <<  @badge
    end
    render body: nil
  end

end
