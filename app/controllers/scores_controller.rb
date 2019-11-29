class ScoresController < ApplicationController
  before_action :set_score, only:[:edit, :edit_transport, :edit_plane, :edit_plane2, :edit_house, :edit_regime, :show, :update, :destroy]
  before_action :authenticate_user!

  def onboarding

      if current_user.scores == []
      redirect_to action: 'new'
      else
        @score = current_user.scores.last
        if @score.regime.present?
          redirect_to bridges_path
        elsif @score.house_size.present?
          redirect_to "/scores/#{@score.id}/edit_regime"
        elsif @score.short_flights.present?
          redirect_to "/scores/#{@score.id}/edit_house"
        elsif @score.long_flights.present?
          redirect_to "/scores/#{@score.id}/edit_plane2"
        elsif @score.main_transport_mode.present?
          redirect_to "/scores/#{@score.id}/edit_plane"
        else
          redirect_to "/scores/#{@score.id}/edit_transport"
        end
      end

  end

  def new
    if cookies[:ajs_anonymous_id].present?
      2.times do
        cookies[:ajs_anonymous_id].slice!("\"")
      end
      Analytics.alias(previous_id: cookies[:ajs_anonymous_id], user_id: current_user.id)
    end
    @score = Score.new
    @countries = Country.all
    AnalyticService.new.track('Onboarding started', nil, current_user)
    render :layout => 'bridges'
  end

  def create
    @score = Score.new(score_params)
    respond_to do |format|
      if @score.save
        AnalyticService.new.track('Country set', nil, current_user)
        format.html { redirect_to "/scores/#{@score.id}/edit_transport", notice: 'Ton impact carbone a été initialisé, répond à quelques questions pour le personnaliser !' }
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
          format.html { redirect_to "/scores/#{@score.id}/edit_plane" }
        elsif request.referer.include? "/edit_plane2"
          AnalyticService.new.track('Short flights set', nil, current_user)
          format.html { redirect_to "/scores/#{@score.id}/edit_house" }
        elsif request.referer.include? "/edit_plane"
          AnalyticService.new.track('Long flights set', nil, current_user)
          format.html { redirect_to "/scores/#{@score.id}/edit_plane2" }
        elsif request.referer.include? "/edit_house"
          AnalyticService.new.track('House set', nil, current_user)
          format.html { redirect_to "/scores/#{@score.id}/edit_regime" }
        elsif request.referer.include? "/edit_regime"
          AnalyticService.new.track('Regime set', nil, current_user)
          format.html { redirect_to bridges_path }
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
