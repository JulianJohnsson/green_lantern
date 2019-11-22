class ScoresController < ApplicationController
  before_action :set_score, only:[:edit, :edit_transport, :edit_plane, :edit_plane2, :edit_house, :edit_regime, :show, :update, :destroy]
  before_action :authenticate_user!

  def new
    2.times do
      cookies[:ajs_anonymous_id].slice!("\"")
    end
    Analytics.alias(previous_id: cookies[:ajs_anonymous_id], user_id: current_user.id)

    if (cookies[:carbo_alpha] == nil && Bridge.find_by_user_id(current_user.id) == nil)
      redirect_to '/waitlist'
    elsif current_user.scores == []
      @score = Score.new
      @countries = Country.all
      AnalyticService.new.track('Onboarding started', nil, current_user)
      render :layout => 'bridges'
    else
      redirect_to bridges_path
    end
  end

  def create
    @score = Score.new(score_params)
    respond_to do |format|
      if @score.save
        AnalyticService.new.track('Country set', nil, current_user)
        format.html { redirect_to "/scores/#{@score.id}/edit_transport", notice: 'Ton impact carbone a été initialisé à partir des données moyennes de ton pays, répond à quelques questions pour le personnaliser !' }
        format.json { render :show, status: :ok, location: @score }
      else
        format.html { render :new }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_transport
    render :layout => 'bridges'
  end

  def edit_plane
    render :layout => 'bridges'
  end

  def edit_plane2
    render :layout => 'bridges'
  end

  def edit_house
    @default = Country.find(@score.country_id).house_size.to_i
    render :layout => 'bridges'
  end

  def edit_regime
    render :layout => 'bridges'
  end

  def edit
    AnalyticService.new.track('Score details displayed', nil, current_user)
  end

  def show
    render :layout => 'bridges'
  end

  def update
    respond_to do |format|
      if @score.update(score_params)
        if request.referer.include? "/edit_transport"
          AnalyticService.new.track('Transport set', nil, current_user)
          format.html { redirect_to "/scores/#{@score.id}/edit_plane", notice: 'Ton impact carbone a bien été mis à jour' }
        elsif request.referer.include? "/edit_plane2"
          AnalyticService.new.track('Short flights set', nil, current_user)
          format.html { redirect_to "/scores/#{@score.id}/edit_house", notice: 'Ton impact carbone a bien été mis à jour' }
        elsif request.referer.include? "/edit_plane"
          AnalyticService.new.track('Long flights set', nil, current_user)
          format.html { redirect_to "/scores/#{@score.id}/edit_plane2", notice: 'Ton impact carbone a bien été mis à jour' }
        elsif request.referer.include? "/edit_house"
          AnalyticService.new.track('House set', nil, current_user)
          format.html { redirect_to "/scores/#{@score.id}/edit_regime", notice: 'Ton impact carbone a bien été mis à jour' }
        elsif request.referer.include? "/edit_regime"
          AnalyticService.new.track('Regime set', nil, current_user)
          format.html { redirect_to bridges_path, notice: 'Ton impact carbone a bien été mis à jour' }
        else
          AnalyticService.new.track('Score details updated', nil, current_user)
          format.html { redirect_to '/track', notice: 'Ton impact carbone a bien été mis à jour' }
        end
        format.json { render :show, status: :ok, location: @score }

      else
        format.html { render edit_score_path(@score) }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  protected

  def set_score
    @score = Score.find(params[:id])
  end

  def score_params
    params.require(:score).permit(:user_id, :country_id, :total, :detail, :main_transport_mode, :long_flights, :short_flights, :house_size, :regime, :kind, :recent_total, :recent_detail, :week_basic_car, :week_electric_car, :week_moto, :week_public_trans, :energy, :enr, :redmeat, :poultry, :dairy, :goods_furnitures, :goods_clothes, :goods_others, :services_health, :services_plans, :services_others)
  end

end
