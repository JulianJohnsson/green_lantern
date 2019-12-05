class Gift < ApplicationRecord
  enum status: [:draft, :formula_chosen, :paid, :payment_failed]

  after_update :update_price, if: :saved_change_to_quantity?
  after_update :update_quantity, if: :saved_change_to_price?

  def update_price
    self.price = self.quantity * 0.02
    self.save
  end

  def update_quantity
    self.quantity = (self.price / 0.02).to_i
    self.save
  end

end
