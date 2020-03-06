class HouseModifierJob < ApplicationJob

  def perform(user)
    UserModifier.house(user)
  end

end
