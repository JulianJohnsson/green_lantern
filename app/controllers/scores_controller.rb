class ScoresController < ApplicationController
  before_action :set_score, only:[:edit_transport, :edit_plane, :update, :destroy]
  before_action :authenticate_user!

  def new
    @score = Score.new
    @countries = Country.all
    render :layout => 'bridges'
  end

  def create
    @score = Score.new(score_params)
    respond_to do |format|
      if @score.save
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

  def update
    respond_to do |format|
      if @score.update(score_params)
        if request.referer.include? "/edit_transport"
          format.html { redirect_to "/scores/#{@score.id}/edit_plane", notice: 'Ton impact carbone a bien été mis à jour' }
          format.json { render :show, status: :ok, location: @score }
        end
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
    params.require(:score).permit(:user_id, :country_id, :total, :detail, :main_transport_mode)
  end

end
