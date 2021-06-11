class Reduction < ApplicationRecord
  belongs_to :user

  scope :visible, -> {where("hidden = FALSE OR hidden IS NULL")}

  def carburant(user)
    score = user.scores.last
    if (score.main_transport_mode||"").to_sym == :voiture_classique || (score.week_basic_car || 0) > 10
      category = Category.find(5)
      month_car_carbon = Country.find(score.country_id).detail[0].to_f * (score.week_basic_car || 90) / 90 *1000/12
      month_car_cost = month_car_carbon * category.coeff
      reduction_coeff = 0.4
      self.category_id = category.id
      self.parent_category_id = category.parent_id
      self.title = "Investir dans un véhicule consommant moins de carburant"
      self.month_carbone =  month_car_carbon*reduction_coeff
      self.month_cost = month_car_cost*reduction_coeff
      self.image = "reduction_voiture.png"
      self.user_id = user.id
      self.color = "danger"
      self.save
    else
      self.month_carbone = 0
      self.hidden = true
      self.save
    end
  end

  def energy_contract(user)
    score = user.scores.last
    if score.enr == nil || score.enr.to_sym == :inconnu || score.enr.to_sym == :partiellement_renouvelable
      category = Category.find(name: 'Énergie')
      if score.enr == nil || score.enr.to_sym == :inconnu
        carbon_reduction = score.detail[1].to_f * 0.5 * 1000/12
      else
        carbon_reduction = score.detail[1].to_f * 0.33 * 1000/12
      end
      cost_reduction = carbon_reduction * category.coeff
      self.category_id = category.id
      self.parent_category_id = category.parent_id
      self.title = "Choisir un contrat 100% énergies renouvelables"
      self.month_carbone =  carbon_reduction
      self.month_cost = cost_reduction
      self.image = "reduction_logement.png"
      self.user_id = user.id
      self.color = "rose"
      self.save
    else
      self.month_carbone = 0
      self.hidden = true
      self.save
    end
  end

  def regime(user)
    score = user.scores.last
    if (Score.regimes[score.regime] || 0) > 1
      case Score.regimes[score.regime] when 2
        reduction_coeff = 0.15
        regime_title = "végétarien"
      when 3
        reduction_coeff = 0.17
        regime_title = "flexitarien"
      when 4
        reduction_coeff = 0.28
        regime_title = "moins carné"
      end
      carbon_reduction = score.detail[4].to_f * reduction_coeff * 1000/12
      category = Category.find(name: 'Alimentation')
      self.category_id = category.id
      self.parent_category_id = category.id
      self.title =  "Passer à un nouveau régime #{regime_title}"
      self.month_carbone =  carbon_reduction
      self.month_cost = 0
      self.image = "reduction_regime.png"
      self.user_id = user.id
      self.color = "primary"
      self.save
    else
      self.month_carbone = 0
      self.hidden = true
      self.save
    end
  end

  def self.average(user)
    transactions = user.transactions
    Category.all.each do |c|
      t = transactions.category_id(c.id)
      red = user.reductions.where("category_id = ?", c.id).last
      if red.present?
        if t.present?
          first_transaction_date = t.order(date: :asc).first.date
          days = [365, (DateTime.now.to_date - first_transaction_date).to_i].min
          category_count = t.carbone_contribution.where("date >= ?", days.days.ago).sum(:carbone) * 30 / days
          all_transactions = Transaction.category_id(c.id).carbone_contribution.where("date >= ?", days.days.ago)
          average_category_count = all_transactions.sum(:carbone) / all_transactions.distinct.count(:user_id)  * 30 / days
          red.month_carbone =  category_count - average_category_count
          red.save
        else
          red.month_carbone = 0
          red.save
        end
        if red.month_carbone <= 0
          red.destroy
        end
      end
        if red == nil && t.count > 2
          first_transaction_date = t.order(date: :asc).first.date
          days = [365, (DateTime.now.to_date - first_transaction_date).to_i].min
          category_count = t.carbone_contribution.where("date >= ?", days.days.ago).sum(:carbone) * 30 / days
          all_transactions = Transaction.category_id(c.id).carbone_contribution.where("date >= ?", days.days.ago)
          average_category_count = all_transactions.sum(:carbone) / all_transactions.distinct.count(:user_id)  * 30 / days
          if category_count > 1.5 *  average_category_count
            red = Reduction.new
            red.category_id = c.id
            red.parent_category_id = c.parent_id
            red.title = "Tu dépenses plus que la moyenne en #{c.name}"
            red.month_carbone =  category_count - average_category_count
            red.month_cost = 0
            red.user_id = user.id
            case c.parent_id when 1
              color = 'danger'
              red.image = "reduction_voiture.png"
            when 12
              color = "rose"
              red.image = "reduction_logement.png"
            when 24
              color = "violet"
            when 25
              color = "warning"
            when 70
              color = "primary"
              red.image = "reduction_regime.png"
            end
            red.color = color
            red.save
          end
        end
    end
  end

end
