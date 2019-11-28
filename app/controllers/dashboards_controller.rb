class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.onboarded != true
      redirect_to '/onboarding'
    else
      # SUIVRE
      @score = current_user.scores.last
      @rand = rand(3)

      # COMPARER
      total = 0
      count = 0
      User.all.onboarded.each do |user|
        total = total + user.scores.last.total
        count = count + 1
      end
      @carbone = @score.total * 1000/12
      @average = total / count * 1000/12

      # REDUIRE
      @reduction = []
      i = 0
      if @score.main_transport_mode == :voiture_classique || (@score.week_basic_car || 0) > 10
        category = Category.find_by_name('Carburant')
        month_car_carbon = Country.find(country_id).detail[0].to_f * (@score.week_basic_car || 90) / 90 *1000/12
        month_car_cost = month_car_carbon * category.coeff
        reduction_coeff = 0.4
        @reduction << ['Transport', Category.find_by_name("Transport").emoji, "Investir dans un véhicule plus propre", month_car_carbon*reduction_coeff, month_car_cost*reduction_coeff]
        i = i + 1
      end
      if @score.enr == nil || @score.enr.to_sym == :inconnu || @score.enr.to_sym == :partiellement_renouvelable
        category = Category.find_by_name('Énergie')
        if @score.enr == nil || @score.enr.to_sym == :inconnu
          carbon_reduction = @score.detail[1].to_f * 0.5 * 1000/12
        else
          carbon_reduction = @score.detail[1].to_f * 0.33 * 1000/12
        end
        cost_reduction = carbon_reduction * category.coeff
        @reduction << ['Logement', Category.find_by_name("Logement").emoji, "Choisir un contrat 100% énergies renouvelables", carbon_reduction, cost_reduction]
        i = i + 1
      end
      if Score.regimes[@score.regime] > 1
        case Score.regimes[@score.regime] when 2
          reduction_coeff = 0.15
          regime_title = "végétarien"
        when 3
          reduction_coeff = 0.17
          regime_title = "flexitarien"
        when 4
          reduction_coeff = 0.28
          regime_title = "moins carné"
        end
        carbon_reduction = @score.detail[4].to_f * reduction_coeff * 1000/12
        @reduction << ['Alimentation', Category.find_by_name("Alimentation").emoji, "Passer à un nouveau régime #{regime_title}", carbon_reduction, 0]
        i = i + 1
      end
      @rand_2 = rand(i)
      @reduction_advice = @reduction[@rand_2]

      # COMPENSER
      @users = User.all.subscribed
      sum = 0
      @users.each do |user|
        sum = sum + user.scores.last.total
      end
      @cars = ((sum+12*6)*1000/12*0.01).to_i
    end
  end

end
