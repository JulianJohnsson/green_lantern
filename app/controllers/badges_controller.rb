class BadgesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_onboarding

  def index
    @badges = Badge.where("active = true")
    AnalyticService.new.track('Display Badges', nil, current_user)
  end

  def calcul
    @badge = Badge.find(1)
  end

  def add
    @badge = Badge.find(params[:badge])
    unless current_user.badges.include?(@badge)
      current_user.badges <<  @badge
      AnalyticService.new.track('Badge Obtained', nil, current_user)
    end
    render body: nil
  end

end
