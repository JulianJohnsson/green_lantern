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
          context: "#{ user.context }",
          verified: "#{ true unless bridge.uuid == nil }",
          onboarded: "#{ user.onboarded }",
          mode: "#{score.kind.to_sym if score.present?}",
          badges_count: user.badges.count,
          subscribed: "#{ true if user.stripe_subscription_id.present? }",
          last_sync_date: "#{ bridge.last_sync_at }",
          user_carbon: "#{ (score.total*1000/12).to_i if score.present? }",
          user_tree: "#{(0.5 + score.total*1000/12 / (750/5)).to_i if score.present? }",
          user_price: "#{ (score.total*1000/12 * 0.02).to_i if score.present? }",
          user_big_category_emoji: "#{ Category.find(score.top_category[0].to_i).emoji if  score.present? && score.top_category.present? }",
          user_big_category_name: "#{ Category.find(score.top_category[0].to_i).name if score.present? && score.top_category.present? }",
          user_big_category_carbon: "#{ score.top_category[1].to_i if score.present? && score.top_category.present? }"
        },
        context: {
          ip: "#{request.remote_ip if request.present?}",
          referer: "#{request.referer if request.present?}",
          integrations: {
           "Google Analytics" => {
              clientId: "#{user.gaid if user.present?}"
           },
           "Intercom" => {
             user_hash: "#{OpenSSL::HMAC.hexdigest("sha256", "pwLHksgcRNZdxQNZlE818_FEIBNt2-JRcfV_VCAA", user.id.to_s) if user.present?}"
           }
          }
        }
      )
    else
      Analytics.identify(
        user_id: "#{ user.id }",
        traits: {
          email: "#{ user.email }",
          name: "#{ user.name }",
          context: "#{ user.context }",
          onboarded: "#{ user.onboarded }",
          mode: "#{score.kind.to_sym if score.present? }",
          badges_count: user.badges.count,
          subscribed: "#{ true if user.stripe_subscription_id.present? }",
          user_carbon: "#{ (score.total*1000/12).to_i if score.present? }",
          user_tree: "#{(0.5 + score.total*1000/12 / (750/5)).to_i if score.present? }",
          user_price: "#{ (score.total*1000/12 * 0.02).to_i if score.present? }"
        },
        context: {
          ip: "#{request.remote_ip if request.present?}",
          referer: "#{request.referer if request.present?}",
          integrations: {
           'Google Analytics' => {
             clientId: "#{user.gaid if user.present?}"
           },
           "Intercom" => {
             user_hash: "#{OpenSSL::HMAC.hexdigest("sha256", "pwLHksgcRNZdxQNZlE818_FEIBNt2-JRcfV_VCAA", user.id.to_s) if user.present?}"
           }
          }
        }
      )
    end
  end

  def track(event,properties,user)
    if user.present? && user.utm_params.present?
      utm = eval(user.utm_params)
      campaign = {
        name: utm[:utm_campaign],
        source: utm[:utm_source],
        medium: utm[:utm_medium]
      }
    end
    Analytics.track(
      event: event,
      properties: properties,
      user_id: "#{user.id if user.present?}",
      context: {
        integrations: {
         'Google Analytics' => {
           clientId: "#{user.gaid if user.present?}"
         }
        },
        campaign: campaign||{}
      }
    )
  end
end
