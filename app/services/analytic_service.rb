class AnalyticService
  def identify(user,request)
    score = user.scores.last
    bridge = Bridge.find_by_user_id(user.id)
    unless bridge == nil
      Analytics.identify(
        user_id: "#{ user.id }",
        traits: {
          email: "#{ user.email }",
          name: "#{ user.name }",
          verified: "#{ true unless bridge.uuid == nil }",
          onboarded: "#{ user.onboarded }",
          mode: "#{score.kind.to_sym}",
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
          name: "#{ user.name }",
          onboarded: "#{ user.onboarded }",
          mode: "#{score.kind.to_sym}"
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
