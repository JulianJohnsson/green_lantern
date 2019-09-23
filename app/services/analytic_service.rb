class AnalyticService
  def identify(user,request)
    bridge = Bridge.find_by_user_id(user.id)
    unless bridge == nil
      Analytics.identify(
        user_id: "#{ user.id }",
        traits: {
          email: "#{ user.email }",
          name: "#{ user.name }",
          verified: "#{ true unless bridge.uuid == nil }",
          onboarded: "#{ bridge.bank_connected }",
          last_sync_date: "#{ bridge.last_sync_at }"
        },
        context: {
          ip: "#{request.remote_ip}",
          referer: "#{request.referer}"
        }
      )
    else
      Analytics.identify(
        user_id: "#{ user.id }",
        traits: {
          email: "#{ user.email }",
          name: "#{ user.name }"
        },
        context: {
          ip: "#{request.remote_ip}",
          referer: "#{request.referer}"
        }
      )
    end
  end

  def track(event,properties,user)
    Analytics.track(
      user_id: "#{user.id}",
      event: event,
      properties: properties
    )
  end
end
