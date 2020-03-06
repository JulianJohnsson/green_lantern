class FoodModifierJob < ApplicationJob

  def perform(user)
    UserModifier.food(user)
  end

end
