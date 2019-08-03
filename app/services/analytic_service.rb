class AnalyticService
  def identify(user)
    bridge = Bridge.find_by_user_id(user.id)
    unless bridge == nil
      Analytics.identify(
        user_id: "#{ user.id }",
        traits: {
          email: "#{ user.email }",
          verified: "#{ true unless bridge.uuid == nil }",
          onboarded: "#{ bridge.bank_connected }",
          last_sync_date: "#{ bridge.last_sync_at }"
        }
      )
    else
      Analytics.identify(
        user_id: "#{ user.id }",
        traits: {
          email: "#{ user.email }"
        }
      )
    end
  end

  def track(event,user)
  end
end
