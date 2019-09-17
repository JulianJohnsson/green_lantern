class Subscription < ApplicationRecord
  belongs_to :user

  after_create_commit :notify_subscription

  def notify_subscription
    AnalyticService.new.track('Subscription asked',
      {
        user_id: self.user_id,
        plan: self.plan,
        price: self.price
      },
        self.user
    )
    UserMailer.new_subscription(self).deliver_later
  end

end
