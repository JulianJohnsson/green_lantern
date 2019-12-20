class SurveyOptinJob < ApplicationJob
  queue_as :default

  def perform(user)
    if user.present? && user.onboarded == true
      user.role = :vip
      user.save
    end
  end

end
