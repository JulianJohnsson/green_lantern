class ReductionGeneratorJob < ApplicationJob
  queue_as :default

  def perform(user)
    carburant = user.reductions.find_by_category_id(5)
    if carburant
      carburant.carburant(user)
    else
      Reduction.new.carburant(user)
    end

    energie = user.reductions.find_by_category_id(17)
    if energie
      energie.energy_contract(user)
    else
      Reduction.new.energy_contract(user)
    end

    regime = user.reductions.find_by_category_id(70)
    if regime
      regime.regime(user)
    else
      Reduction.new.regime(user)
    end

  end

end
