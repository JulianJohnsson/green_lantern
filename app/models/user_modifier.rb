class UserModifier < ApplicationRecord
  belongs_to :user
  belongs_to :category

  def self.food(user)
    score = user.scores.last
    if score.redmeat == nil && score.poultry == nil && score.dairy == nil
      case score.regime.to_sym when :moyen
        modifier = 0
      when :végétalien
        modifier = -0.463
      when :végétarien
        modifier = -0.3955
      when :flexitarien
        modifier = -0.2553
      when :viandard
        modifier = 0.5093
      end
    else
      modifier = (((score.redmeat || 0) - 3) * 0.14 + ((score.poultry || 0) - 4) * 0.053 + ((score.dairy || 0) - 4) * 0.017) / Country.find(score.country_id).detail[4].to_f
    end
    categories = [70,72,73,75]
    categories.each do |cat|
      unless user.user_modifiers.find_by_category_id(cat).present? && user.user_modifiers.find_by_category_id(cat).carbone_modifier == modifier
        mod = UserModifier.new
        mod.category_id = cat
        mod.user_id = user.id
        mod.carbone_modifier = modifier
        mod.save
      end
    end
  end
end
